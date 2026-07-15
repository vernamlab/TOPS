# Phase1 — S11 Measurement

Description
-----------
This collection contains a Python script to measure the S11 response of a chip PDN using an eVNA (Vector Network Analyzer) and to find frequencies where the chip absorbs the most energy. The script acquires N traces and plots the averaged S11 (magnitude) vs frequency to improve measurement repeatability.

High-level workflow
-------------------
1. Calibrate the eVNA using OSL calibration on Port 1 (Open, Short, Load).
2. Configure the eVNA measurement parameters (frequency range, points, power, ...) in eVNA Studio.
3. Connect the eVNA to the chip PDN hardware.
4. Run the Python script which collects N traces and plots the average trace (the script example collects 20 traces and plots their average).
5. Inspect the averaged S11 trace to identify frequencies with highest absorption (lowest S11 magnitude, or resonant dips depending on plotting convention).

Requirements
------------
Hardware
- eVNA instrument (ensure Port 1 is working and calibrated)
- Coaxial cables to connect eVNA Port1 to the chip PDN
- The DUT (chip) and any required network in the test setup

Software
- Python 3.8+ (3.9/3.10 recommended)
- eVNA Studio (used for calibration and instrument configuration)
- Make sure you can control the eVNA from Python

Setup and calibration
---------------------
1. Open eVNA Studio and connect to your eVNA instrument.
2. Perform OSL calibration for Port 1:
   - Use the O (Open) standard on Port 1 and follow the eVNA OSL routine.
   - Repeat for S (Short) and L (Load).
3. After calibration, set measurement parameters in eVNA Studio:
   - Frequency start/stop range: in this project we used 3 kHz to 100 MHz
   - Number of points: 201 (this speeds measurements; increase for higher frequency resolution)
   - Power level: set according to your DUT safe levels and dynamic range needs
   - IF bandwidth
   - Ensure that the instrument is set to measure S11 magnitude
4. Save or note the instrument configuration so the measurements are consistent.


Using the Python script
-----------------------
1. Edit the Python script to set any required paths and parameters:
   - Change the directory path for saving outputs (SAVE_DIR) to a folder on your machine.
   - Set the number of traces to average (N_TRACES). The example script uses 20 traces.


Important notes
---------------
- NOTE: Remember to change the save directory path in the script to your own directory before running.


License & contact
-----------------
