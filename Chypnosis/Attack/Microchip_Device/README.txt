=====================================================================================================================================================
DESCRIPTION
=====================================================================================================================================================

this project contains everything to recreate the Chypnosis experiments, except for the improved borrowed time implementation.

The top-level module consists of...
	the CoreSMIP_PF module, with the means to read the flag signals via LEDs
	two registers that are written to when the SLOW_CLOCK and VOLT_DETECT_1PO_LOW signals go high
	a switch to enable zeroization from the SLOW_CLOCK or VOLT_DETECT_1PO_LOW (via ERASE_P)

For the purposes of this project, the DIP switches should be looked at such that DIP1 is on the right, and DIP8 is on the left. From this
perspective, if a switch is down, that is 0, and if a switch is up, that is 1.

Some of these experiments are dependent on the clock frequency. So we can very the clock frequency, we use SEG_DSP_IO1 as a clock input from a
function generator. Alternatively, you can change the clock pin to the on-board 50MHz oscillator by commenting out line 8 of io/disco_constr.pdc and
uncommenting line 5.

IMPORTANT! Be sure supply VDD from an actual power supply when programming. In addition, hold SWITCH1 and SWITCH2, because the device will instantly
zeroize otherwise (see note 1).


=====================================================================================================================================================
BOARD SETUP
=====================================================================================================================================================

PolarFire SoC Discovery Kit (Part No. MPFS-DISCO-KIT)

Disconnect on-board regulator from VDD
	desolder inductor L10

Remove a bunch of decoupling caps
	C152
	C162
	C161
	C144
	C140
	C134
	C169
	i did not desolder these, as they are beyond my abilities...
		C128, C130, C129, C121, C122, C120, C108, C109, C110, C112, C111, C113

Add something to connect external power supply to VDD
	i used a BNC to DuPont header cable, similar to this https://www.amazon.com/XMSJSIY-Dupont-Connector-Adapter-Extension/dp/B09MK6JTGH?th=1
	positive to the VDD test point (right next to where the inductor used to be)
	negative to C144 pad (closest exposed ground after the modifications)

This was good enough to make work to the best of our equipment's abilities, but if you have better equipment you can probably improve the setup to
achieve a faster voltage drop.


=====================================================================================================================================================
LED display settings
=====================================================================================================================================================

DIP 4 3 2 1 | LED 7                     6                     5                     4                     3                     2                     1
    0 0 0 0 |     MASTER_ALARM          CRITICAL_ALARM        1'b0                  flags[3]              flags[2]              flags[1]              flags[0]
    0 0 0 1 |     MASTER_ALARM          CRITICAL_ALARM        1'b0                  flags[7]              flags[6]              flags[5]              flags[4]
    0 0 1 0 |     MASTER_ALARM          CRITICAL_ALARM        1'b0                  flags[11] (note 1)    flags[10]             flags[9]              flags[8]
    0 0 1 1 |     MASTER_ALARM          CRITICAL_ALARM        1'b0                  flags[15]             flags[14]             flags[13]             flags[12]
    0 1 0 0 |     MASTER_ALARM          CRITICAL_ALARM        1'b0                  flags[19]             flags[18]             flags[17]             flags[16]
    0 1 0 1 |     MASTER_ALARM          CRITICAL_ALARM        1'b0                  flags[23]             flags[22]             flags[21]             flags[20]
    0 1 1 0 |     MASTER_ALARM          CRITICAL_ALARM        1'b0                  flags[27]             flags[26]             flags[25]             flags[24]
    0 1 1 1 |     MASTER_ALARM          CRITICAL_ALARM        1'b0                  flags[31]             flags[30]             flags[29]             flags[28]
	1 0 0 0 |     MASTER_ALARM          CRITICAL_ALARM        SLOW_CLOCK            VOLT_DETECT_1PO_HIGH  VOLT_DETECT_1PO_LOW   slow_clock_reg        volt_detect_reg
    1 0 0 1 |     count[6]              count[5]              count[4]              count[3]              count[2]              count[1]              count[0]
	1 0 1 x |     1'b0                  1'b0                  1'b0                  1'b0                  1'b0                  1'b0                  1'b0
	1 1 x x |     1'b0                  1'b0                  1'b0                  1'b0                  1'b0                  1'b0                  1'b0


=====================================================================================================================================================
OTHER I/O
=====================================================================================================================================================

SWITCH1     - clear all flags, clear registers
SWITCH2     - reset CoreSMIP_PF
DIP5        - enable zeroization from VOLT_DETECT_1PO_LOW, SLOW_CLOCK
SEG_DSP_IO2 - CoreSMIP_PF heartbeat signal (toggles every 1000 clock cycles)

=====================================================================================================================================================
SOME EXPERIMENTS
=====================================================================================================================================================

a) verify hibernation with counter
	set DIP4:1 switches to 1001
	see counter going up
	undervolt
	all LEDs go off
	return to nominal
	counter continues exactly where it left off
	if you went too low, counter will reset

b) defeat VOLT_DETECT_1PO_LOW and SLOW_CLOCK 
	set DIP4:1 switches to 1000
	power VDD rail from function generator (note 2), set to square wave with long period, ~10s
	press SWITCH1 and SWITCH2 to reset CoreSMIP_PF, volt_detect_reg, slow_clock_reg, and all flags
	on the falling edge, device should hibernate
	after the rising edge, volt_detect_reg, and slow_clock_reg LEDs should not be on
	VOLT_DETECT_1PO_HIGH will be on, rising edge has overshoot
	works for slow_clock consistenly for a clock frequency up to 25MHz
	works for VOLT_DETECT_1PO_LOW inconsistently up to 25MHz

c) defeat zeroization
	same setup as experiment b
	set DIP5 to 1 (enables zeroization)
	zeroization does not happen. tested up to 25MHz


=====================================================================================================================================================
NOTES
=====================================================================================================================================================

1) the LOCK_ERROR flag is always asserted and I do not know how to prevent this. To my knowledge, it has nothing to do with the voltage
   countermeasures, but it is considered "critical" and will automatically trigger zeroization. My workaround is to constantly clear it so it is
   not my problem.

2) the voltage settings on a function generator are based on an assumption about load impedance which is broken with this setup. Thus experimentally
   determine the high and low levels to correspond with nominal and hibernation voltages. On the Tektronix function generators, I use 4.6V for
   nominal, and 0.5V for hibernation at a load impedance of 50ohm, but your mileage may vary