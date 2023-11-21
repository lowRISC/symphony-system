# Mailbox

The mailbox provides small (32-bit) message passing between Sonata and Earl Grey.
Interrupts are used for message notifications.

## Theory of Operation

There are two mailboxes, one for each direction that can hold a single message each.
When a message is posted in a mailbox an interrupt is raised to Earl Grey or Sonata (depending on which mailbox has the message) to notify of the incoming message.

There is no fixed format for messages, it is entirely software defined.
Where a message does not fit into 32 bits the SRAM banks can be used to carry more data.
Hardware does nothing to assist in this, software defined messages should include a field for an offset into an SRAM bank that can be used as an address.

## Registers

### Message

*Read-write*

<p align="center"><img src="images/mailbox_message_register.svg" width="800"></p>

Register that holds a message, it is either in a full or empty state.
Each message register has a fixed sender and recepient.
The mailbox is aware if it is the sender or recepient that is accessing a register (via the Tile Link ID) and has different behaviours for each.

When in an empty state a write from the sender will switch to the full state and raise an interrupt to the recipient.

When in a full state a read from the recipient will return the message written and clear the interrupt.

Any write from the recipient is ignored and any read from the sender returns 0.
Writes from the sender are ignored in the full state and reads from the recipient return 0 in the empty state.

### Status

*Read-only*, writes are ignored.

<p align="center"><img src="images/mailbox_status_register.svg" width="800"></p>

Indicates empty/full status of each message register.
`full 0` is the status of message 0 and `full 1` is the status of message 1.

### Interrupt Enable

*Read-write*

<p align="center"><img src="images/mailbox_interrupt_enable_register.svg" width="800"></p>

The `intr_en` field control the interrupt enable for either Sonata or Earl Grey (there is a separate enable register for each).
If an interrupt is disabled but has been triggered (the corresponding message register is full) then enabling the interrupt will cause it be immediately raised.

Writes from Sonata or Earl Grey to the other's interrupt enable register are ignored.
Reads from Sonata or Earl Grey to the other's interrupt enable register always return 0.

## Register Offsets

| Offset | Register                        |
| ------ | ------------------------------- |
| 0x0    | Message 0 (Sonata to Earl Grey) |
| 0x4    | Message 1 (Earl Grey to Sonata) |
| 0x100  | Interrupt Enable (Earl Grey)    |
| 0x104  | Interrupt Enable (Sonata)       |
| 0x108  | Status                          |
