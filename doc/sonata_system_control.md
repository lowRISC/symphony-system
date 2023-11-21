# Sonata System Control

This block controls the clock, reset, power and boot vector of Sonata.
On power up Sonata will be held in reset with the power and clock disabled.
Earl Grey must turn it on and boot it with the Sonata System Control block.

## Theory of Operation

Each of the clock, reset and power is under the control of Earl Grey.
Direct access is given to the clock and power enables for the Sonata System.
It is the software's reponsibility to obey any specific sequencing requirements (e.g. a minimum period between power enable and clock enable).
Reset is also under direct Earl Grey control.
To reset, software must first assert the reset then deassert the reset.
The system starts with the reset asserted.
The block handles all clock and reset domain crossing requirements.

## Registers

### Control

*Read-write*

<p align="center"><img src="images/sonata_system_control_register.svg" width="800"></p>

`pwr_en` and `clk_en` control the power and clock enables respectively.
`reset` asserts and deasserts the reset.

An 8-bit encoding is used for each field which is given below.
For the `reset` the `Enabled` encoding asserts the reset and the `Disabled` encoding deasserts the reset.
Values that don't match either of these encodings have the same effect as `Disabled`.
It is not recommended you use the other values for `Disabled` as the recommended encoding has been chosen to have a hamming distance of 4 from the `Enabled` encoding.

| Value   | Meaning                |
| ------- | ---------------------- |
| 0x78    | Enabled                |
| 0xF6    | Disabled (Recommended) |
| others  | Disabled               |



### Boot Vector

*Read-write*

<p align="center"><img src="images/sonata_system_boot_vector_register.svg" width="800"></p>

Specifies the address (in Sonata address space) that Sonata boots from.

## Register Offsets

| Register Name | Offset |
| ------------- | ------ |
| Control       | 0x0    |
| Boot Vector   | 0x4    |
