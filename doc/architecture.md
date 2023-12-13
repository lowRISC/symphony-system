# Symphony architecture specification

Symphony brings together [OpenTitan Earl Grey](https://github.com/lowRISC/opentitan) (an open silicon root of trust) and the [Sonata](https://github.com/lowRISC/sonata-system) CHERIoT Ibex system.
Earl Grey is production quality (including extensive DV) and security hardened.
Symphony leverages the functionality and quality level of Earl Grey.
It is intended for applications that want to utilize CHERIoT but also require the security functionality and guarantees that can be obtained with a root of trust.

Unlike Earl Grey, Symphony will not be brought to production quality within the scope of the Sunburst project.
In particular whilst due consideration will be given towards security hardening it will not receive the same level of scrutiny and validation as Earl Grey.

The Symphony architecture comprises a number of components:
- FPGA configuration architecture:
  What changes do we make to [Sonata](https://github.com/lowRISC/sonata-system), what changes to we make to [OpenTitan Earl Grey](https://opentitan.org/book/hw/top_earlgrey/doc/datasheet.html) and how do we connect the two together?
  It defines everything we are using a hardware description language for.
- Software architecture:
  How do we compose Earl Grey and Sonata together?
  How do we enable Sonata to use peripherals and services provided by Earl Grey?

## FPGA configuration architecture

The target board for the Symphony system is the [NewAE CW340](https://media.newae.com/datasheets/NAE-CW340-OTKIT_datasheet.pdf).

### Sonata system

A cut down version of the [Sonata](https://github.com/lowRISC/sonata-system/) system will be used.
Most of the peripherals are not required as the Earl Grey peripherals be used via peripheral donation instead (see Software architecture).
The follow parts of Sonata will be included:

- CHERIoT Ibex
- CHERIoT debug module
- DMA
- UART
- GPIO
- SRAM

### OpenTitan Earl Grey

Modifications to Earl Grey will be kept to an absolute minimum.
Avoiding changes minimizes the risk of introducing new bugs or security issues.
The main modification will be to the two crossbars to enable the connection of the [bridge interface](bridge_interface.md).

### [Bridge interface](bridge_interface.md)

The bridge interface connects the Sonata system to Earl Grey.
Sonata communicates with the bridge interface exclusively via a TileLink port.
Earl Grey can raise an interrupt in the Sonata system via the bridge interface and has control over the clock, reset, power enable and boot vector of the Sonata system.
On power up, the Sonata system will be inactive with its startup controlled by Earl Grey via the bridge interface.

## Software architecture

### [CHERIoT Secure Boot](cheriot_secure_boot.md)

The boot of the CHERIoT Ibex core in Sonata is controlled entirely by Earl Grey.
Sonata does not have its own embedded flash or SPI peripheral.
This means all accesses to non-volatile storage from Sonata must be mediated by Earl Grey.
Earl Grey provides a secure boot flow to Sonata to enable this.

### Peripheral Donation

Earl Grey has a number of useful peripherals that Sonata may wish to use.
The peripheral donation mechanism allows Sonata to access these via the bridge interface.
