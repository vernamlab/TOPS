# AMD RTL Designs

This directory contains RTL source code and supporting files intended for AMD-targeted experiments. The document below explains what the code is intended to do, how you can use it, important limitations and safety considerations.

## Purpose and Scope

The purpose of this GitHub repository is to record temperature, voltage rails, and clock behavior. It also includes a ring-oscillator (RO) module and its counter, which are used as a delay-based sensor.


## What the Designs Will Do

This repository is designed to monitor and record chip behavior over time. Specifically, it records:

* Temperature over time
* `VCCINT` and `VCCAUX` voltage rails over time
* PLL clock sensor `LOCK` signal
* Two counters that monitor the input and output clocks of the PLL IP
* Ring oscillator (RO) counter values over time, measured over 100,000 clock cycles


> [!Note]
> Since our experiments were performed under cryogenic temperatures, we used an external clock from a function generator for UART communication and the RO counter. For other design purposes, this clock source can be changed to an internal or board-provided clock.

> [!Note]
> We used an ESP-Prog module for UART communication, so the UART signals are connected through PMOD pins. These pins can be changed based on your own board setup or design requirements.


## Getting Started

1. Create a new project in the Vivado Design Suite.
2. Choose the target sub-folder (`implementation/Spartan7/` or `implementation/Zynq-UltraScale+/`) and import all files from its `rtl`, `design`, and `constraint` folders into the project.
3. Generate the bitstream and program the FPGA device.
4. Communicate with the chip using the provided Python notebook in `data_collection/`.

> [!Note]
> For the Zynq UltraScale+ platform, the PL clock is generated from the PS side. Therefore, Linux must be booted on the board.


## Attribution and Contact

## License 
