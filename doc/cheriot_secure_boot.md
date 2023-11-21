# CHERIoT Secure Boot

*Note the flow here is provided as an example of a potential secure boot flow.*
*It has not received the same level of scrutiny as the Earl Grey secure boot flow and would require further refinement for production use-cases.*

Earl Grey itself boots using the existing [Open Titan secure boot process](https://opentitan.org/book/doc/security/specs/secure_boot/index.html).
This boots into firmware developed for Symphony that controls the CHERIoT secure boot process.

The CHERIoT secure boot is separated into two stages:

## Stage 1 - CHERIoT Boot ROM Load

Earl Grey loads and verifies a small 'boot ROM' from it's internal flash and copies it into the shared SRAM connected to the bridge interface (giving a maximum size of 8 KiB for the boot ROM).
Provided verification was successful, Sonata's clock and power are enabled and it is brought out of reset.
The boot vector points to the code in the shared SRAM and Earl Grey enables read and execute for the SRAM.
From Sonata's point of view the initial boot stage is identical to booting from a fixed ROM at a fixed address.

## Stage 2 -- CHERIoT Boot ROM Execute

The boot ROM performs the initial Sonata system setup and loads the main Sonata firmware image.
It uses security services provided by Earl Grey to verify an image stored in Earl Grey's internal flash (using external flash instead would be possible but the initial Symphony system won't have support for it).
Earl Grey maps the firmware image into Sonata's address space and Sonata jumps to it (if verification succeeds).
The Earl Grey firmware only maps the firmware image if the verification has succeeded.
Should there be an injected fault causing Sonata to believe verification has succeeded when it has failed Sonata won't be able to execute the code it incorrectly jumps to.
For Earl Grey existing security hardening (in both software and hardware) mitigates fault injection attacks that could cause it to incorrectly map the firmware image into the Sonata address space following verification failure.

The firmware loads further things as it deems necessary, it could copy code in Sonata's SRAM for direct execution or just continue executing from Earl Grey's flash.

## Execute from External Flash

Support for executing out of external flash is not included in the scope of Symphony however it would be possible to add.
Earl Grey contains a quad speed serial peripheral interface (QSPI) controller that could be used to access an external flash, however it does not contain a controller that can translate Tile Link transactions commands to access the flash via QSPI.
Instead software must generate the required commands and copy data from the QSPI's received data to an appropriate memory.
Sonata could simply read from external flash using the QSPI controller this way but everything read would need to be placed in SRAM.

To avoid needing a copy to SRAM a suitable controller would be needed for the QSPI controller so TileLink transactions can produce suitable flash reads.
There are a few possibilities of how this could be used:
 - With the controller coupled to an SPI host block provided as an entirely new block, connected to the external device port on the bridge crossbar.
 - Earl Grey could be further modified so one of its SPI hosts has the controller.
 - The controller itself could be part of Sonata and send appropriate TileLink transactions to an existing Earl Grey SPI host that will send the commands to read the flash.
