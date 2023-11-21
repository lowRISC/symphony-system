# Shared SRAM

The shared SRAM consists of two separate 4 KiB banks.
The banks can be accessed in parallel, so Sonata can access one the same cycle Earl Grey accesses the other.

A write monitor allows Earl Grey to be notified on writes to the SRAM.

## Theory of Operation

Two Tile Link ports connect the shared SRAM to the bridge interface crossbar.
Both Tile Link ports can access both banks.
If both ports present an access in the same cycle they can both proceed if they're targetting different SRAM banks.
If they target the same SRAM bank static arbitration is used giving Earl Grey the priority.

The write monitor can monitor one 32-bit region per bank.
This means there are two write monitors in total, each with its own address to monitor and interrupt.

## Registers

### Monitor Address

*Read-write*

<p align="center"><img src="images/shared_sram_monitor_address_register.svg" width="800"></p>

`addr` gives the address to monitor within a particular SRAM bank.
This is an aligned address and as such the bottom 2 bits are not required.
When the `valid` bit is set any write within that 32-bit region triggers the interrupt.

### Interrupt Status

*Read-write*

<p align="center"><img src="images/shared_sram_monitor_interrupt_status.svg" width="800"></p>

The `intr_0` and `intr_1` fields indicate whether the interrupt for the write monitor of bank 0 and 1 monitor have been triggered, respectively.
Writing 0 to these fields acknowledges and clears the interrupt.

### Interrupt Enable

*Read-write*

<p align="center"><img src="images/shared_sram_monitor_interrupt_enable.svg" width="800"></p>

The `intr_en_0` and `intr_en_1` fields control the enable for interrupts 0 and 1.
If an interrupt is disabled but has been triggered (the corresponding `intr_0` or `intr_1` is set) then enabling the interrupt will cause it be immediately raised with Earl Grey.

## Register Offsets

| Offset | Register                 |
| ------ | --------                 |
| 0x0    | Monitor Address (Bank 0) |
| 0x4    | Monitor Address (Bank 1) |
| 0x8    | Interrupt Status         |
| 0xc    | Interrupt Enable         |
