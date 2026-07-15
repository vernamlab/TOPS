# Chypnosis SW

This repository collects the software-side sources used in the Chypnosis experiments. The focus is on two related workflows:

1. Experiments on a Xilinx 7-series target, including undervolting, SRAM/data-retention observations, and frequency-domain impedance-oriented analysis using ChipWhisperer.
2. UART-side control scripts for calling the protected AES hardware function on OpenTitan and integrating it into ChipWhisperer-based capture flows.

The repository is intentionally source-oriented. Generated traces, exported measurement files, plots, and notebook outputs are excluded from version control so the repo stays lightweight and easy to share.

## Repository Layout

- `Analyze/`
  Cleaned notebook for voltage/frequency sweeps on the 7-series target. This is the starting point for the CW-Lite-based undervolting and retention experiments.
  Cleaned notebook plus a reusable plotting script for converting saved sweep data into heatmaps and quick summary plots.
- `Attack/Opentitan/`
  UART scripts for setting AES keys, sending plaintexts, and verifying AES responses from an OpenTitan target once the board is configured and running.

## Hardware Context

- **ChipWhisperer Lite (CW-Lite)** is the capture/control platform used here.
- The **7-series FPGA experiments** are used for undervolting, SRAM/data-retention observations, and impedance-oriented sweeps.
- The **OpenTitan flow** uses UART scripts to talk to the AES hardware target after OpenTitan has been built and loaded for the supported FPGA setup.

## OpenTitan Setup

The OpenTitan board bring-up changes over time, so the safest starting point is the official repository and documentation:

- OpenTitan repository: <https://github.com/lowRISC/opentitan>
- OpenTitan documentation: <https://opentitan.org/book/>

Primitive setup commands:

```bash
git clone https://github.com/lowRISC/opentitan.git
cd opentitan
git submodule update --init --recursive
python3 -m pip install -r python-requirements.txt
```

From there, follow the current FPGA / ChipWhisperer setup guide in the official OpenTitan documentation for:

- tool installation
- FPGA image build/load
- firmware build/load
- UART console access
- board-specific configuration details

Once OpenTitan is up and responding on UART, the scripts in `Attack/Opentitan/` can be used to:

- set the AES key
- send plaintext to the AES hardware engine
- read back the ciphertext
- verify the response against a software AES reference

Typical UART-side usage:

```bash
python Attack/Opentitan/serial_key.py --port <serial-port> --key 00112233445566778899aabbccddeeff
python Attack/Opentitan/serial_enc.py --port <serial-port> --plaintext 00112233445566778899aabbccddeeff
python Attack/Opentitan/test_7.py --port <serial-port>
```

Use the correct serial device for your system, for example `COM5` on Windows.

## CW Frequency / Impedance Workflow

The cleaned notebook in `Analyze/` is the main source notebook for the 7-series sweep experiments. The intended flow is:

1. Configure the CW-Lite and target FPGA bitstream.
2. Sweep frequency and core voltage.
3. Save the collected `points` list to a text export such as `Analyze/Results/freq_volt3.txt`.
4. Reuse the same saved sweep data for:
   - clock-health plots
   - recovery behavior plots
   - assignment-state maps
   - impedance-oriented visual inspection

This means the same CW frequency-analysis data can also support impedance analysis, as long as the capture/export format is preserved.

## Plotting Results

The plotting notebook and script expect a saved text export produced from the sweep notebook. The expected file format is a Python-style list of dictionaries containing fields such as:

- `freq`
- `volt`
- `clock_count`
- `clock_counter_rec`
- `reg_assign_rec`
- `blocking_assign_rec`

The cleaned plotting script already includes:

- clock-count heatmap
- recovery clock-count heatmap
- register-assignment heatmap
- voltage sweep line plot at the highest available frequency

Run it with:

```bash
python Analyze/Results/03_plot.py Analyze/Results/freq_volt3.txt
```

Plots are written to `Analyze/Results/generated_plots/` by default.

## Notes On The Current Data Source

The original plotting notebook referenced `freq_volt3.txt`, but that raw data file is not included in this repository. The current cleaned workflow therefore treats the frequency/voltage sweep export as an external generated file. In other words, the plots are gathered from the **CW frequency sweep export**, not from a checked-in CSV in this repo.

## Python Requirements

Install the packages in `requirements.txt` before running the notebooks or scripts.

