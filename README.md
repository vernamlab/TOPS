# TOPS

ChypSnipe is a collection of hardware-security research projects targeting FPGA-based systems. The repository is organized into three independent modules, each studying a different attack vector or characterization technique.

---

## Chypnosis

**Chypnosis** focuses on undervolting and side-channel experiments on FPGA targets.

---

## Chypothermia

**Chypothermia** is a framework for studying FPGA behavior when clocks are slowed or stopped under cryogenic and varied-temperature conditions, enabling static side-channel analysis.


---

## GlitchSnipe

**GlitchSnipe** investigates frequency-dependent, spatially localized voltage fault injection on FPGAs by treating the power delivery network (PDN) as a frequency-selective channel.


---

## Repository Structure

```
TOPS/
├── Chypnosis/       # CW-Lite sweep scripts and OpenTitan UART tools
├── Chypothermia/    # cryogenic measurement notebooks
└── GlitchSnipe/     # PDN profiling, TDC spatial mapping, and AES fault injection
```

Each subfolder contains its own README with platform-specific setup instructions, hardware requirements, and usage details.

---

> **Responsible use:** All experiments are intended for authorized academic research and hardware-security evaluation only. Perform side-channel and fault-injection experiments solely on hardware you own or have explicit permission to test.
