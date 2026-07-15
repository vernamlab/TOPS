# Phase 3: AES-128 Frequency-Based Fault Injection on CW305

This repository contains the Phase 3 AES attack setup used in the **GlitchSnipe** research project.  
The goal of Phase 3 is to use the frequency-dependent sensitivity map obtained from earlier profiling phases to inject faults into an AES-128 implementation on the ChipWhisperer CW305 FPGA board.

The experiment targets an AES-128 core implemented on the **NewAE CW305** board with an **AMD Artix-7 XC7A100T** FPGA. The FPGA runs the AES design at **100 MHz**, while an RF signal generator modulates the FPGA core voltage rail (`VCCINT`) over a selected frequency range. The Python attack script repeatedly executes AES encryptions, sweeps the modulation frequency, collects faulty ciphertexts, and logs the frequency points that produce faults.


---

## Background

In conventional voltage glitching, a short pulse is injected into the supply rail. In this project, instead of using a broadband pulse, we modulate `VCCINT` with a sinusoidal signal at a selected frequency. The idea is that different frequency components propagate through the FPGA power delivery network (PDN) differently, creating location-dependent voltage disturbances on the die.

Phase 3 uses the profiling results from the earlier phases:

1. **Phase 1:** Measure the PDN frequency response using `S11`.
2. **Phase 2:** Use distributed TDC sensors to find sensitive FPGA regions at each modulation frequency.
3. **Phase 3:** Place target logic, such as AES state registers, in selected regions and apply frequency-based voltage modulation to induce exploitable faults.


---

## Hardware Requirements

- NewAE ChipWhisperer CW305 board (AMD/Xilinx Artix-7 `XC7A100T` FPGA target)
- ChipWhisperer capture/control board or CW305-compatible host setup
- RF signal generator, such as Keysight N9310A
- Coaxial cable from RF output to the CW305 `VCCINT` injection/SMA path
- Host computer with USB access to CW305 and the RF signal generator
- Optional: oscilloscope or power monitoring equipment for debugging

---

## Software Requirements

- Python 3.10 or newer
- Jupyter Notebook or JupyterLab
- Vivado Design Suite
- ChipWhisperer Python package
- PyVISA
- NumPy
- PyCryptodome
- tqdm

Install the main Python dependencies:

```text
- chipwhisperer
- pyvisa
- numpy
- pycryptodome
- tqdm
- jupyter
```

Depending on your RF signal generator, you may also need the correct VISA backend, such as NI-VISA or pyvisa-py.

---

## AES Hardware Design

The AES-128 design is based on the NewAE ChipWhisperer FPGA firmware examples:

https://github.com/newaetech/chipwhisperer/tree/develop/firmware/fpgas

For this experiment, the AES design is built for the CW305 `XC7A100T` target. The attack notebook expects the generated bitstream to be named:

```text
cw305_top.bit
```

The notebook programs the FPGA using:

```python
target = cw.target(scope, cw.targets.CW305, bsfile=r"cw305_top.bit", force=True)
```

Place the bitstream in the same directory as the notebook, or update the `bsfile` path in the notebook.

---

## Building the Bitstream

1. Clone or download the ChipWhisperer FPGA firmware repository.
2. Open the CW305 AES project in Vivado.
3. Add or modify the AES RTL and constraints as needed for your placement experiment.
4. Generate the bitstream for `XC7A100T`.
5. Copy the generated `.bit` file to the attack directory and rename it to:

```text
cw305_top.bit
```

---

## Attack Notebook

The main attack notebook is:

```text
aes_attack-cw305.ipynb
```

The notebook performs the following steps:

1. Connects to the ChipWhisperer scope.
2. Programs the CW305 FPGA with `cw305_top.bit`.
3. Sets `VCCINT` to `1.0 V`.
4. Configures the CW305 PLL output to `100 MHz`.
5. Connects to the RF signal generator using PyVISA.
6. Sets the RF output amplitude to `+20 dBm`.
7. Generates random plaintexts.
8. Writes the AES key into the FPGA.
9. Sweeps the modulation frequency.
10. Repeatedly triggers AES encryption.
11. Reads the ciphertext.
12. Compares the FPGA ciphertext with the software AES reference.
13. Logs any faulty ciphertext event.

---

## Default Experiment Parameters

The current notebook uses the following default parameters:

```python
target.vccint_set(1.0)
target.pll.pll_outfreq_set(100E6, 1)

Ampl = 20

start_freq = 1e6
end_freq = 10e6
num_points = 5000

pts = rand_pt_like(200)

for trial in range(200):
    target.usb_trigger_toggle()
```

This means:

| Parameter | Value |
|---|---:|
| FPGA core voltage | `1.0 V` |
| AES clock | `100 MHz` |
| RF amplitude | `+20 dBm` |
| Frequency range | `1 MHz` to `10 MHz` |
| Frequency points | `5000` |
| Plaintexts | `200` |
| Repeated trials per plaintext/frequency | `200` |

For the paper-scale experiment, these values can be changed to match the selected scenario, such as using a `1 MHz` to `9 MHz` sweep or changing the number of plaintexts and frequency points.

---

## Running the Experiment

Start Jupyter:

```bash
jupyter notebook
```

Open:

```text
aes_attack-cw305.ipynb
```

Then run the cells in order.

Before running the attack loop, check that:

- The CW305 is detected.
- The FPGA is programmed successfully.
- The ADC clock locks.
- The RF signal generator responds to `*IDN?`.
- The RF output is initially OFF.
- The bitstream path is correct.
- The SMA/RF connection to the CW305 injection path is correct.

During the experiment, the notebook turns the RF output ON during the sweep and turns it OFF at the end.

---

## Output Logs

The script creates a `logs/` directory and writes a timestamped log file:

```text
logs/app_<timestamp>.log
```

---

## Fault Detection Method

For each plaintext, the notebook computes a correct AES reference ciphertext in software:

```python
ct_ref = AES.new(key, AES.MODE_ECB).encrypt(pt)
```

Then the FPGA AES output is read:

```python
faulty_ct = target.fpga_read(target.REG_CRYPT_CIPHEROUT, 16)[::-1]
```

If the FPGA ciphertext differs from the software reference, the notebook records the byte positions that changed:

```python
fault_indexes = [i for i in range(16) if ct_ref[i] != faulty_ct[i]]
```

These logged byte indexes can later be used to evaluate whether the faults are useful for differential fault analysis.
To verify that the generated faulty ciphertexts were exploitable, we used the open-source DFA-AES implementation from https://github.com/arusson/dfa-aes to recover the full AES key. Specifically, we applied the 9th-round DFA attack using 8 correct/faulty ciphertext pairs. This confirmed that the faults produced by our frequency-based voltage modulation were not only observable, but also practically exploitable for end-to-end key recovery.

---

## Notes on AES Placement Experiments

In the paper, Phase 3 evaluates AES attacks with different state-register placements. The purpose is to study how spatial sensitivity affects the fault rate and the probability of generating useful DFA faults.

A typical experiment flow is:

1. Use the TDC profiling result to identify sensitive regions.
2. Place selected AES state bytes near those regions.
3. Generate the AES bitstream.
4. Sweep the modulation frequency.
5. Record which frequencies cause faults in which ciphertext bytes.
6. Compare the fault behavior with the TDC sensitivity map.

This makes it possible to study whether certain modulation frequencies are more effective at disturbing specific AES state-register locations.

---

## Citation

---

## Disclaimer

This project is intended for authorized academic research on FPGA fault injection, power delivery network characterization, and hardware-security evaluation. Do not use it on systems that you do not own or do not have permission to test.
