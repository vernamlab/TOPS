======================================================================================================================================================
OVERVIEW
======================================================================================================================================================

When the PLL is locked, registers are written to once. This will make all register values opposite what they reset/preset to (reset regs store 1,
preset regs store 0), and these are all tied to turn LED1 of the board off (see andall and store signals). When you undervolt, NOT-locked should
trigger the async clears (if it indeed works when undervolted). This will flip all the register values and turn on LED1 (when you revive the board
from undervolting without a crash).


======================================================================================================================================================
BOARD SETUP
======================================================================================================================================================

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


======================================================================================================================================================
I/O
======================================================================================================================================================

DIP1    = register enable input
LED1    = AND of all registers
LED2    = PLL locked signal
LED2    = register enable output
SWITCH1 = clear registers (reset experiment)


======================================================================================================================================================
EXPERIMENT
======================================================================================================================================================

Using DIP1, enable the register and write to it, then disable it. LED1 should turn off. Then undervolt VDD. If async clear works, then LED1 should
turn on when returning from undervolting.

