# Bridge Crossbar

The crossbar connects all of the blocks on the bridge interface with Earl Grey.
It has an additional Tile Link host port for another device or crossbar to connect to.
The base Symphony system doesn't connect anything to it, it is an optional feature for users who wish to expand the base Symphony system.

## Theory of Operation

The crossbar is constructed in a similar way to those in Earl Grey (see the [Earl Grey TL-UL Specification](https://opentitan.org/book/hw/ip/tlul/index.html)).
It connects to two hosts, the Sonata system (via the access port) and Earl Grey.
It links separately into the high-speed domain and peripheral domain cross bars in Earl Grey.
In each of these crossbars it can only transact with a subset of the connected devices.
This is enforced through the physical connectivity of the crossbars, there is no way to route a transaction from the bridge crossbar to the excluded devices on the Earl Grey crossbars.

The crossbar and all of the bridge interface device are in the Earl Grey high speed domain.

## Reachable Earl Grey Devices

The following devices in Earl Grey can receive transactions from the bridge crossbar

 * SPI Host 0, 1
 * USB
 * UART 0 - 3
 * I2C 0 - 2
 * Flash (read-only access, no access to flash control configuration registers)
