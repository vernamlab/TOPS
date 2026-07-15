# GlitchSnipe: Toward Localized Voltage Fault Attacks

This repository contains the code, FPGA designs, constraints, and Python notebooks used for the **GlitchSnipe** research project. The project studies how voltage fault injection can have **location-dependent effects** on an FPGA die when the FPGA power rail is disturbed at different modulation frequencies.

Instead of treating voltage glitching as only a global time-domain pulse, this project analyzes the FPGA power delivery network (PDN) in the frequency domain. The main idea is that different frequencies propagate through the board, package, and die PDN differently, which can make some FPGA regions more sensitive than others. The repository is organized into three phases:

1. **Phase 1:** Measure the PDN frequency response using S11.
2. **Phase 2:** Use distributed TDC sensors to map frequency-dependent sensitive regions on the FPGA.
3. **Phase 3:** Use the profiling results to perform frequency-based fault injection on AES-128 and demonstrate end-to-end key recovery.

> **Disclaimer:** This repository is intended only for authorized academic research and hardware-security evaluation. Do not use it on devices or systems that you do not own or do not have permission to test.

---

## Research Overview

Voltage fault injection is commonly considered a global disturbance because the injected glitch is applied to a shared power rail. However, in practice, different regions of the chip can respond differently to the same disturbance. In GlitchSnipe, we model the PDN as a frequency-selective communication channel. By measuring the PDN response and then injecting sinusoidal voltage modulation at selected frequencies, we study how different frequencies affect different FPGA locations.

The workflow is:

1. Measure the board and chip PDN response using S11.
2. Identify frequency bands where the system absorbs more energy.
3. Sweep voltage modulation frequencies in the selected band.
4. Measure local timing changes using distributed TDC sensors.
5. Build a spatial-frequency sensitivity map.
6. Use this map to guide fault injection on target logic such as FSMs and AES.

---

## Phase 1: S11 Measurement

The first phase measures the frequency response of the chip PDN using an eVNA/vector network analyzer. The goal is to find frequency bands where the PDN absorbs more injected energy, which correspond to more vulnerable or sensitive frequency regions.

### Purpose

Phase 1 is used to:

- Calibrate the VNA/eVNA using Open, Short, Load calibration.
- Measure the S11 response of the DUT PDN.
- Average multiple traces to improve repeatability.
- Identify resonant or low-reflection frequency bands.
- Select a narrower frequency range for later voltage-modulation experiments.


### Hardware

- Mini-Circuits eVNA or compatible VNA
- Coaxial cables
- DUT board, such as NewAE CW305
- Access to the FPGA PDN injection path

### Software

- Python 3.8+
- eVNA Studio or compatible instrument software
- Python instrument-control support for the VNA/eVNA
- NumPy and Matplotlib

---

## Phase 2: TDC-Based Spatial Profiling

The second phase implements distributed Time-to-Digital Converter (TDC) sensors on the FPGA to measure local timing and voltage-sensitivity changes across the die.

### Target Platform

| Item | Description |
|---|---|
| Board | NewAE CW305 |
| FPGA | AMD/Xilinx Artix-7 `XC7A35T-FTG256` |
| Number of TDCs | 79 |
| TDC width | 64 bits |
| Main FPGA clock | 100 MHz |
| TDC clock | 250 MHz |
| Communication | UART through ESP-Prog |
| FPGA tool | Vivado Design Suite |
| Measurement notebook | `02_TDC_Profiling/python/TDC_Measurement.ipynb` |

### Purpose

Phase 2 is used to:

- Program the CW305 with the distributed TDC design.
- Calibrate each TDC so that the output contains approximately half ones and half zeros.
- Sweep the RF modulation frequency on `VCCINT`.
- Read all 79 TDC outputs through UART.
- Count the number of ones in each 64-bit TDC output.
- Save the measurement results.
- Generate frequency-dependent spatial sensitivity maps.



## Phase 3: AES-128 Frequency-Based Fault Injection

The third phase uses the spatial-frequency sensitivity map from Phase 2 to perform fault injection on an AES-128 implementation. The goal is to show that the frequency-dependent effects measured by the TDCs can be used to guide an end-to-end fault attack.
NOTE: Because the DUT changed from the `XC7A35T` to the `XC7A100T`, we repeated Phase 2 on the XC7A100T device as well. This allowed us to generate a new TDC-based sensitivity map for the 100T FPGA and identify the frequency-sensitive locations specific to this DUT before running the AES attack. For this DUT, we implemented 163 TDC sensors across the FPGA fabric. 

### Target Platform

| Item | Description |
|---|---|
| Board | NewAE CW305 |
| FPGA | AMD/Xilinx Artix-7 `XC7A100T` |
| Target design | AES-128 |
| AES clock | 100 MHz |
| Injection rail | `VCCINT` |
| RF modulation | Sinusoidal modulation from RF signal generator |

### AES Design Reference

The AES-128 hardware design is based on the NewAE ChipWhisperer FPGA firmware examples:

```text
https://github.com/newaetech/chipwhisperer/tree/develop/firmware/fpgas
```

The generated bitstream is expected to be named:

```text
cw305_top.bit
```

Place the bitstream in the same directory as the attack notebook or update the `bsfile` path in the notebook.

### Why TDC-Guided AES Placement Was Used

In our attack, the goal was to demonstrate the relationship between fault location and modulation frequency and to show an end-to-end attack. Therefore, we used the TDC profiling results to guide the placement of the AES state registers. This allowed selected AES states to be placed in regions with different sensitivity to specific frequencies. We then evaluated whether the observed faulty ciphertexts matched the predicted spatial-frequency sensitivity from the TDC map.

### Running the AES Attack Notebook

Open:

```text
03_DFA_Attack/aes_attack-cw305.ipynb
```

The notebook performs the following steps:

1. Connects to the ChipWhisperer scope.
2. Programs the CW305 FPGA with the AES bitstream.
3. Sets `VCCINT` to `1.0 V`.
4. Sets the AES clock to `100 MHz`.
5. Connects to the RF signal generator using PyVISA.
6. Sets the RF output amplitude.
7. Generates plaintexts.
8. Writes the AES key to the FPGA.
9. Sweeps the modulation frequency.
10. Runs AES encryption repeatedly.
11. Reads the ciphertext.
12. Compares the FPGA ciphertext with the software AES reference.
13. Logs any faulty ciphertext event.



### DFA Verification

To make sure the generated faulty ciphertexts were exploitable, we used the open-source DFA-AES implementation from:

```text
https://github.com/arusson/dfa-aes
```

Specifically, we used the 9th-round DFA attack with 8 correct/faulty ciphertext pairs to recover the full AES key. This confirmed that the faults generated by frequency-based voltage modulation were not only observable, but also exploitable for end-to-end key recovery.

---

## General Hardware Requirements

The full project may require:

- NewAE CW305 board with `XC7A35T` or `XC7A100T` FPGA
- ChipWhisperer capture/control setup
- ESP-Prog USB-to-UART adapter for TDC readout
- Mini-Circuits eVNA or compatible VNA
- RF signal generator, such as Keysight N9310A
- Coaxial cables and SMA connections
- Host computer with USB and VISA support
- Optional oscilloscope or power monitor for debugging

---

## General Software Requirements

- Python 3.10+ recommended
- Jupyter Notebook 
- Vivado Design Suite
- ChipWhisperer Python package
- PyVISA
- PySerial
- NumPy
- Matplotlib
- tqdm
- PyCryptodome
- VISA backend, such as NI-VISA, Keysight IO Libraries, or pyvisa-py


Depending on your instrument setup, additional drivers may be required.

---

## Important Notes

- Update all absolute paths before running the notebooks or scripts.
- Check the correct COM port or serial device name before UART communication.
- Make sure the RF output is OFF before connecting or changing cables.
- Use safe voltage and RF power levels for your DUT.
- The XDC constraints are specific to the FPGA package and placement used in this project.
- Some FPGA regions cannot host TDC sensors because the required resources are not available.

---

## Citation



---

## License



---

## Contact

