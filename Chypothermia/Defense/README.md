# Ring-Oscillator Farm → Self-Heating Countermeasure (Spartan-7)

On-chip **self-heating countermeasure** for the **Chypothermia** clock-freezing /
static side-channel attack. This is the RO-farm heater from Section 8.1 of the
Chypothermia paper: a distributed farm of three-stage ring oscillators placed
around a temperature-sensitive clock-stop sensor to keep its delay path in the
nominal regime, defeating cooling-based evasion of the sensor. Targets the
Digilent **Arty S7-50**; RO enables are driven from the board's **Pmod JB**
header and mirrored to the on-board LEDs.

## Threat model → why this exists

The combined **Chypothermia + Chypnosis** attack cools the chip to a moderate
temperature (≈ −36 °C ambient, deliberately kept above a typical −40 °C
anti-tamper threshold so no temperature alarm fires). On AMD 7-Series parts the
cooling slows the delay-based clock-stop sensor (a buffer chain) through the
**inverse temperature dependence (ITD)** effect: the added propagation delay
widens the sensor's detection window. That extra slack gives the attacker time
to apply a fast voltage drop (Chypnosis) and halt the clock **before** the
sensor asserts `stop_detect`, so the zeroization response never fires and secret
state (e.g., an AES key) survives for static extraction via LLSI.

The attack hinges on low temperature stretching the sensor's buffer-chain delay.
The countermeasure closes that gap by actively heating the sensor back into its
calibrated timing window.

## Countermeasure mechanism

Ring oscillators are efficient on-chip heaters — pure CMOS logic, placeable
almost anywhere on the die, and self-heating strongly even at cryogenic bath
temperatures. This design surrounds the delay-based clock-stop sensor with a
distributed farm of **1500 three-stage ROs** (paper, Figure 10). When active,
the farm raises the local die temperature enough to pull the sensor's buffer
chain back into its nominal delay window, so it again asserts `stop_detect`
within its expected timing and the zeroization response fires normally —
mitigating the combined attack.

In the paper's full countermeasure the farm is **not** always on: an on-die
**XADC** temperature reading gates it, activating the ROs once the die falls
below a set threshold (−29 °C, the XADC-reported die temperature when the
chamber holds −36 °C). At that point the heated die sits ≈ 7 °C above ambient:
warm enough to keep the sensor responsive, still below the −40 °C alarm
threshold. Sizing came from sweeping active ROs at a fixed −36 °C ambient
(paper, Table 2), 1500 active three-stage ROs hold the die at ≈ −22.5 °C, which
was sufficient.

> **This repo vs. the full loop:** these sources are the **heater element only**,
> the RO farms, with enables exposed on Pmod JB for external/manual control
> (matching the characterization setup). The closed-loop **XADC controller** that
> auto-activates the farm below the threshold is described in the paper but is
> *not* part of this RTL. Drive `jb_en` from your own controller (or an XADC
> path) to complete the countermeasure loop.

## Target

| Item      | Value                               |
|-----------|-------------------------------------|
| Board     | Digilent Arty S7-50                 |
| FPGA      | `xc7s50csga324-1` (Spartan-7)       |
| Toolchain | Xilinx Vivado (developed on 2023.1) |

The pinout in `xdc/cons.xdc` is the source of truth for the board mapping.

## Layout

```
Defense/
├── RO_Farm/
│   ├── src/
│   │   ├── top_module.v         # top: 4 RO farms, Pmod-JB enables, LED mirror
│   │   ├── ro_farm.v            # parameterized farm of N ring oscillators
│   │   └── ring_oscillator.v    # 3-stage enable-gated ring oscillator
│   └── xdc/
│       └── cons.xdc             # Arty S7 pin + configuration constraints
└── rebuild.tcl                  # recreates the project and builds the bitstream
```

## Design

- **`ring_oscillator.v`** , a 3-stage inverter ring gated by `en`
  (`b[0] = ~b[N-1] & en`). `dont_touch` / `S` attributes stop synthesis from
  optimizing the combinational loop away.
- **`ro_farm.v`** , instantiates `NUM_RO` ring oscillators in a `generate` loop
  and buses their outputs; `KEEP` / `DONT_TOUCH` preserve every instance so they
  actually switch and generate heat.
- **`top_module.v`** , four farms on `jb_en[3:0]`: farms 1–3 hold 2 ROs each,
  farm 4 holds **1500** (the deployed heater size). Each enable is mirrored to
  `led[3:0]`, so the LEDs show which farms are active. Independent Pmod-JB
  enables let you switch farms separately for characterization.

## Overhead (paper figures, Spartan-7)

- **Area:** three stages × 1500 ROs ≈ **4500 LUTs**.
- **Power:** ≈ **323 mW** on the core rail with 1500 ROs active, vs ≈ 30 mW
  disabled (≈ 0.2 mW per RO). Because the farm is enabled only below the
  temperature threshold, it adds no power overhead at nominal temperatures.

## Build

Requires Vivado (any Spartan-7-capable version; developed on 2023.1):

```bash
vivado -mode batch -source rebuild.tcl
```

This recreates the project under `build/` (gitignored), runs synthesis and
implementation, and writes the bitstream to `top_module.bit` next to the
script. In the GUI, run the same file via *Tools → Run Tcl Script…*.

## Program

Open the Vivado Hardware Manager, connect to the Arty S7, and program
`top_module.bit`. Assert the Pmod-JB enable lines to activate the farms; the
LEDs confirm which farms are running.
