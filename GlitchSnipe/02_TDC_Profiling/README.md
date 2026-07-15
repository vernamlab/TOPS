# CW305 TDC Measurement Framework

This repository contains the FPGA design files and Python measurement notebook used to implement and read out distributed Time-to-Digital Converter (TDC) sensors on the NewAE CW305 platform.

The design targets the AMD/Xilinx Artix-7 `XC7A35T-FTG256` FPGA and instantiates **79 64-bit TDC sensors** across the FPGA fabric. The TDCs are used to measure local timing/voltage-sensitivity changes across the chip during voltage disturbance experiments.


## Overview

Voltage fault injection is often treated as a global disturbance, but in practice different regions of the FPGA fabric can react differently to the same power-rail disturbance. This project uses an array of distributed TDC sensors to measure those spatial differences.

The repository includes:

- RTL files for the TDC-based measurement design
- XDC constraint files for placing 79 TDCs on the `XC7A35T`
- A Python notebook for programming the CW305, communicating with the FPGA, calibrating the TDCs, and collecting measurements


## Target Platform

| Item | Description |
|---|---|
| Board | NewAE CW305 |
| FPGA | AMD/Xilinx Artix-7 `XC7A35T-FTG256` |
| Number of TDCs | 79 |
| TDC width | 64 bits |
| FPGA tool | Vivado Design Suite |
| Communication | UART through ESP-Prog |
| Main FPGA clock | 100 MHz |
| TDC sampling clock | 250 MHz, generated in the FPGA design |
| Python version | Python 3.x; Python 3.12 was used in the paper experiments |


## Software Requirements

Install the required Python packages:

```text
- chipwhisperer
- pyserial
- pyvisa
- numpy
- matplotlib
- tqdm
```

Depending on your RF signal generator/VISA backend, you may also need NI-VISA, Keysight IO Libraries, or another compatible VISA backend.

## Building the FPGA Bitstream

1. Open Vivado.
2. Create a new RTL project targeting `XC7A35T-FTG256`.
3. Add all files from the `rtl/` folder.
4. Add the constraint files from the `constraint/` folder.
5. Synthesize, implement, and generate the bitstream.
6. Save the generated bitstream path and update it in `TDC_Measurement.ipynb`.

In the notebook, update this line to match your generated bitstream:

```python
target = cw.target(
    scope,
    cw.targets.CW305,
    bsfile=r"path\to\cw305_top.bit",
    force=True
)
```

## Running the Measurement Notebook

Open:

```text
python/TDC_Measurement.ipynb
```

Then run the notebook sections in order.

### 1. Program the FPGA

The notebook uses the ChipWhisperer CW305 API to program the FPGA bitstream.

```python
scope = cw.scope()
target = cw.target(scope, cw.targets.CW305, bsfile=r"path\to\cw305_top.bit", force=True)
```

It also sets the core voltage and configures the CW305 PLL output:

```python
target.vccint_set(1.0)
target.pll.pll_outfreq_set(100E6, 1)
```

### 2. Open UART Communication

Update the serial port name for your system:

```python
fpga_ser = open_serial_device(serial_dev="COM15", baudrate=115200, timeout=1)
```

Examples:

- Windows: `COM15`
- Linux: `/dev/ttyUSB0`

### 3. Configure TDC Parameters

The notebook supports UART commands to:

- Select a TDC ID
- Set the TDC measurement cycle count
- Trigger a TDC measurement
- Read TDC measurement data
- Set coarse-tune values
- Read stored TDC values from memory

Important parameter:

```python
N = 1
```

`N` is the **number of TDC measurement cycles**. A larger value gives more samples and improves measurement accuracy, but it also increases the measurement time.

For example:

```python
N = 1000
```

can be used when higher averaging accuracy is needed.

### 4. Calibrate the TDCs

Each TDC is calibrated by adjusting its coarse-tune value so that the sensor output contains approximately half ones and half zeros.

ex: b'\x00\x00\x00\x00\xff\xff\xff\xff'



### 5. Collect TDC Measurements

After calibration, the notebook loops over all 79 TDCs, triggers measurements, counts the number of valid ones in each 64-bit TDC output, and saves the results.

The output is saved as `.trc` files, for example:

```text
TDCs_Freq_<frequency>.trc
```

Update the output folder in the notebook:

```python
parent_dir = r"path\to\output"
directory = "TDC_results"
```

## RF Signal Generator Support

The notebook includes optional PyVISA control for a Keysight N9310A RF signal generator.

Uncomment it and update the instrument index/address before running:

```python
rm = pyvisa.ResourceManager()
instruments = rm.list_resources()
n9310a_address = instruments[4]
n9310a = rm.open_resource(n9310a_address)
```

You can set the RF amplitude and frequency using:

```python
n9310a.write(":AMPLITUDE:CW " + str(Ampl) + "dBm")
n9310a.write(":FREQ:CW " + str(freq) + "Hz")
```

Make sure `Ampl` is defined before using the RF-control section.



## Post-Processing

The notebook includes simple post-processing code for `.trc` files:

```python
averages = process_trc_files(trc_directory)
global_average = np.mean(averages, axis=0)
```

This computes the average TDC value for each trace and the global average across all traces.

## Notes

- Update all absolute paths before running the notebook.
- Check the UART port before starting the experiment.
- The XDC constraints are specific to the `XC7A35T-FTG256` placement used in this project.
- Some FPGA regions cannot host TDC sensors because the required placement resources are not available.
- Increasing the number of measurement cycles improves accuracy but makes each experiment slower.
- The RF signal generator section is optional and can be skipped for basic TDC readout.

## External Code References

This project builds on the following open-source hardware components:

- **TDC sensor implementation:**  
  We used the 7-Series TDC sensor VHDL implementation from the `remote-fpga-attacks-book-chapter` repository as the basis for our TDC sensors:  
  `https://github.com/mirjanastojilovic/remote-fpga-attacks-book-chapter/tree/main/sensors/tdc/7Series`

- **Multi-byte UART communication:**  
  We used the multi-byte UART communication modules from the HyperDbg hardware-debugging repository to communicate with the FPGA and read measurement data from the chip:  
  `https://github.com/HyperDbg/HyperDbg/tree/master/hwdbg/src/main/systemverilog/sensors/src`

We modified and integrated these modules into our CW305 Artix-7 design to support distributed TDC measurements and UART-based data collection.

## Citation

