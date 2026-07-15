"""Plot ChipWhisperer frequency/voltage sweep results.

Expected input:
    A trusted local text export produced from the CW sweep notebook, usually
    saved as ``freq_volt3.txt``.  The file should contain a Python-style list of
    dictionaries, where each dictionary stores fields such as ``freq``, ``volt``,
    ``clock_count``, ``clock_counter_rec``, ``reg_assign_rec``, and
    ``blocking_assign_rec``.

This script keeps the plotting logic out of the notebook so the notebook stays
short and reviewable.
"""

from __future__ import annotations

import argparse
from pathlib import Path

import matplotlib.colors as mcolors
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd


def load_points(path: Path) -> list[dict]:
    """Load the trusted text export created by the CW sweep notebook."""
    raw_text = path.read_text(encoding="utf-8")
    safe_globals = {"__builtins__": {}}
    safe_locals = {"bytearray": bytearray}
    points = eval(raw_text, safe_globals, safe_locals)
    if not isinstance(points, list):
        raise ValueError(f"Expected a list of points in {path}.")
    return points


def _normalize_value(value) -> int:
    if isinstance(value, (bytes, bytearray)):
        return int.from_bytes(value, byteorder="little")
    return int(value)


def metric_dataframe(points: list[dict], field: str) -> pd.DataFrame:
    records = []
    for entry in points:
        if field not in entry:
            continue
        records.append(
            {
                "freq": float(entry["freq"]),
                "volt": float(entry["volt"]),
                "value": _normalize_value(entry[field]),
            }
        )

    if not records:
        raise ValueError(f"No records found for field '{field}'.")

    return pd.DataFrame.from_records(records).sort_values(["freq", "volt"])


def build_heatmap(frame: pd.DataFrame) -> pd.DataFrame:
    return frame.pivot(index="volt", columns="freq", values="value").sort_index()


def plot_log_heatmap(heatmap: pd.DataFrame, title: str, colorbar_label: str, output_path: Path) -> None:
    masked = np.ma.masked_where(heatmap.values <= 0, heatmap.values)
    positive_values = heatmap.values[heatmap.values > 0]
    vmin = max(1, positive_values.min()) if positive_values.size else 1
    vmax = max(vmin, heatmap.values.max())
    norm = mcolors.LogNorm(vmin=vmin, vmax=vmax)

    fig, ax = plt.subplots(figsize=(9, 5))
    cmap = plt.cm.Blues.copy()
    cmap.set_bad(color="white")
    image = ax.imshow(masked, cmap=cmap, norm=norm, origin="lower", aspect="auto")

    ax.set_title(title)
    ax.set_xlabel("Frequency (MHz)")
    ax.set_ylabel("Voltage (V)")

    x_values = heatmap.columns.to_numpy()
    y_values = heatmap.index.to_numpy()
    x_ticks = np.linspace(0, len(x_values) - 1, min(6, len(x_values)), dtype=int)
    y_ticks = np.linspace(0, len(y_values) - 1, min(8, len(y_values)), dtype=int)
    ax.set_xticks(x_ticks, [f"{x_values[idx] / 1e6:.0f}" for idx in x_ticks])
    ax.set_yticks(y_ticks, [f"{y_values[idx]:.2f}" for idx in y_ticks])

    colorbar = fig.colorbar(image, ax=ax)
    colorbar.set_label(colorbar_label)

    fig.tight_layout()
    fig.savefig(output_path, dpi=200, bbox_inches="tight")
    plt.close(fig)


def plot_state_heatmap(
    heatmap: pd.DataFrame,
    title: str,
    label_map: dict[int, str],
    output_path: Path,
) -> None:
    unique_values = sorted(int(value) for value in pd.unique(heatmap.values.ravel()) if pd.notna(value))
    colors = plt.cm.tab10(np.linspace(0, 1, max(len(unique_values), 1)))
    cmap = mcolors.ListedColormap(colors[: len(unique_values)])
    bounds = [value - 0.5 for value in unique_values] + [unique_values[-1] + 0.5]
    norm = mcolors.BoundaryNorm(bounds, cmap.N)

    fig, ax = plt.subplots(figsize=(9, 5))
    image = ax.imshow(heatmap.values, cmap=cmap, norm=norm, origin="lower", aspect="auto")
    ax.set_title(title)
    ax.set_xlabel("Frequency (MHz)")
    ax.set_ylabel("Voltage (V)")

    x_values = heatmap.columns.to_numpy()
    y_values = heatmap.index.to_numpy()
    x_ticks = np.linspace(0, len(x_values) - 1, min(6, len(x_values)), dtype=int)
    y_ticks = np.linspace(0, len(y_values) - 1, min(8, len(y_values)), dtype=int)
    ax.set_xticks(x_ticks, [f"{x_values[idx] / 1e6:.0f}" for idx in x_ticks])
    ax.set_yticks(y_ticks, [f"{y_values[idx]:.2f}" for idx in y_ticks])

    colorbar = fig.colorbar(image, ax=ax, ticks=unique_values)
    colorbar.ax.set_yticklabels([label_map.get(value, str(value)) for value in unique_values])

    fig.tight_layout()
    fig.savefig(output_path, dpi=200, bbox_inches="tight")
    plt.close(fig)


def plot_highest_frequency_line(frame: pd.DataFrame, title: str, output_path: Path) -> None:
    highest_frequency = frame["freq"].max()
    subset = frame[frame["freq"] == highest_frequency].sort_values("volt")

    fig, ax = plt.subplots(figsize=(8, 4))
    ax.plot(subset["volt"], subset["value"], marker="o")
    ax.set_title(f"{title} at {highest_frequency / 1e6:.0f} MHz")
    ax.set_xlabel("Voltage (V)")
    ax.set_ylabel("Clock Count")
    ax.grid(True, alpha=0.3)
    fig.tight_layout()
    fig.savefig(output_path, dpi=200, bbox_inches="tight")
    plt.close(fig)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Generate plots from a CW frequency/voltage sweep export."
    )
    parser.add_argument(
        "data_file",
        type=Path,
        help="Path to the exported sweep file, e.g. Plot_results/freq_volt3.txt",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=Path(__file__).resolve().parent / "generated_plots",
        help="Directory for generated plot images.",
    )
    args = parser.parse_args()

    if not args.data_file.exists():
        raise FileNotFoundError(
            f"{args.data_file} does not exist. Export the 'points' list from "
            "CW_Freq_analysis/cw_analysis.ipynb first."
        )

    args.output_dir.mkdir(parents=True, exist_ok=True)
    points = load_points(args.data_file)

    clock_frame = metric_dataframe(points, "clock_count")
    recovery_frame = metric_dataframe(points, "clock_counter_rec")
    register_frame = metric_dataframe(points, "reg_assign_rec")
    blocking_frame = metric_dataframe(points, "blocking_assign_rec")

    plot_log_heatmap(
        build_heatmap(clock_frame),
        "Clock Count During Undervolting",
        "Clock Count (log scale)",
        args.output_dir / "clock_count_heatmap.png",
    )
    plot_log_heatmap(
        build_heatmap(recovery_frame),
        "Clock Count After Recovery",
        "Recovered Clock Count (log scale)",
        args.output_dir / "clock_count_recovery_heatmap.png",
    )
    plot_state_heatmap(
        build_heatmap(register_frame),
        "Recovered Register Assignment State",
        {
            136: "Old value",
            155: "Intermediate",
            187: "New value",
            255: "Crash",
        },
        args.output_dir / "register_assignment_heatmap.png",
    )
    plot_state_heatmap(
        build_heatmap(blocking_frame),
        "Recovered Blocking Assignment State",
        {
            192: "Lost",
            204: "Error",
            208: "Partial",
            221: "Successful",
            238: "Previous value",
            255: "Crash",
        },
        args.output_dir / "blocking_assignment_heatmap.png",
    )
    plot_highest_frequency_line(
        clock_frame,
        "Clock Count vs Voltage",
        args.output_dir / "clock_count_highest_frequency.png",
    )

    print(f"Loaded {len(points)} sweep points from {args.data_file}.")
    print(f"Plots written to {args.output_dir}.")


if __name__ == "__main__":
    main()
