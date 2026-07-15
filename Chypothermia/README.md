# Chypothermia: Clock Freezing for Static Side-channel Attacks

This repository contains the artifact for **Chypothermia**, a framework for studying FPGA behavior when clocks are slowed or stopped under cryogenic and varied-temperature conditions. The included RTL designs expose clock, environmental, and delay-based measurements over UART so that a host can record device behavior and evaluate static side-channel measurements.

> **Anonymous artifact:** Author names, affiliations, contact details, and publication links are intentionally omitted for anonymous review.

## Repository contents

| Directory | Target | Contents |
| --- | --- | --- |
| [`Attack/AMD_Devices/`](Attack/AMD_Devices/) | AMD Spartan-7 and Zynq UltraScale+ | RTL, Vivado IP, constraints, and a Python notebook |
| [`Attack/Microchip_Device/`](Attack/Microchip_Device/) | Microchip PolarFire MPFS095T-1FCSG325E | RTL, Libero components, constraints, setup images, and a Python notebook |

The designs provide platform-dependent access to:

- On-chip temperature and voltage measurements
- PLL status, including the clock `LOCK` signal
- Counters for observing PLL input and output clocks
- A ring oscillator and counter used as a delay-based sensor
- UART commands for configuration and measurement collection

## Requirements

### Hardware

- One of the supported FPGA boards
- A programming/debug connection supported by the relevant vendor tools
- A UART adapter; the reference setups use an ESP-Prog connection through PMOD or Raspberry Pi header pins
- An external clock source for reproducing the reference experiments
- Appropriate temperature-control equipment when performing cryogenic experiments

The reference designs use an external **12.5 MHz** clock for reliable UART communication and measurement timing. An internal or board-provided clock may be substituted, but the RTL, constraints, and host configuration may need to be adjusted.

### Software

- AMD Vivado Design Suite for targets under `AMD/`
- Microchip Libero SoC for the PolarFire target
- Python 3 

Tool and IP versions should be selected to support the chosen FPGA and board. Generated vendor IP may require regeneration when opened with a different tool release.

## Quick start

1. Select a supported target and read its platform-specific documentation:
   - [AMD setup and implementation](Attack/AMD_Devices/README.md)
   - [Microchip PolarFire setup and implementation](Attack/Microchip_Device/README.md)
2. Create a project in Vivado or Libero SoC.
3. Import the target's RTL, vendor IP or component files, and constraints.
4. Build the design, generate a bitstream, and program the FPGA.
5. Connect the UART adapter and the selected clock source.
6. Open the corresponding notebook and update its serial-port setting for the host system:
   - [`Attack/AMD_Devices/data_collection/data_collection.ipynb`](Attack/AMD_Devices/data_collection/data_collection.ipynb)
   - [`Attack/Microchip_Device/data_collection/chypothermia_microchip_polarfire.ipynb`](Attack/Microchip_Device/data_collection/chypothermia_microchip_polarfire.ipynb)
7. Run the notebook to communicate with the device, collect measurements, and plot the results.

For the Zynq UltraScale+ design, the programmable-logic clock is supplied from the processing system; Linux must therefore be booted on the board before running the experiment.

## Reproducing the reference setup

Pin assignments, UART routing, clock sources, and vendor IP configuration are board-specific. Review the constraint files before programming hardware. 

Exact results depend on the device, board, clock configuration, tool version, voltage, and thermal conditions. Record these parameters alongside collected data when comparing runs.

## Safety and responsible use

Cryogenic operation can damage hardware and create risks from condensation, thermal stress, and improper handling of cooling equipment. Use suitable laboratory controls, allow hardware to return to a safe temperature before powering or handling it, and follow the equipment manufacturers' guidance.

This artifact is intended for authorized research and evaluation. Only perform side-channel experiments on hardware and systems you own or have explicit permission to test.

## License


