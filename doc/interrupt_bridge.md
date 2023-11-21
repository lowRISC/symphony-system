# Interrupt Bridge

Passes interrupts lines from Earl Grey through to Sonata.
Earl Grey controls which interrupt lines are sent.

## Theory of Operations

A fixed subset of Earl Grey interrupt lines are connected into the interrupt bridge.
There is an enable bit for each interrupt.
When the interrupt is enabled it is sent through to Sonata.
The pass through uses a simple masking scheme.
When enabling an interrupt through the bridge if an interrupt is raised on the Earl Grey side it will be instantly raised on the Sonata side.
Similarly when disabling an interrupt through the bridge whilst it is raised it will be instanatly dropped on the Sonata side.

When Earl Grey is donating a peripheral to Sonata and enabling the relevant interrupts on the bridge it is recommended interrupts are disabled at the peripheral to avoid Sonata receiving interrupts during the donation process.
The expectation is Sonata will enable the interrupts it is interested in when the peripheral donation is complete.
Similarly interrupts should be disabled at the peripheral when Sonata is releasing the donated peripheral back to Earl Grey.

## Registers

### Enable Register

*Read-write*

<p align="center"><img src="images/interrupt_bridge_enable_register.svg" width="800"></p>

One bit per interrupt enable.
Each register has 32 enable bits.
The bit index within this register of an enable is `Bridge ID % 32`.
The index of the register of an enable is `Bridge ID / 32`.

## Register Offsets

| Register Name | Offset |
| ------------- | ------ |
| Enable 0      | 0x0    |
| Enable 1      | 0x4    |
| Enable 2      | 0x8    |
| Enable 3      | 0xc    |

## Interrupt Mapping Table

This table provides a mapping from the Earl Grey PLIC IRQ IDs to the Interrupt Bridge IDs

| Interrupt Name                   | Earl Grey PLIC IRQ ID | Interrupt Bridge ID |
| ------------------------------   | --------------------- | ------------------- |
| `Uart0TxWatermark`               | 1                     | 0                   |
| `Uart0RxWatermark`               | 2                     | 1                   |
| `Uart0TxEmpty`                   | 3                     | 2                   |
| `Uart0RxOverflow`                | 4                     | 3                   |
| `Uart0RxFrameErr`                | 5                     | 4                   |
| `Uart0RxBreakErr`                | 6                     | 5                   |
| `Uart0RxTimeout`                 | 7                     | 6                   |
| `Uart0RxParityErr`               | 8                     | 7                   |
| `Uart1TxWatermark`               | 9                     | 8                   |
| `Uart1RxWatermark`               | 10                    | 9                   |
| `Uart1TxEmpty`                   | 11                    | 10                  |
| `Uart1RxOverflow`                | 12                    | 11                  |
| `Uart1RxFrameErr`                | 13                    | 12                  |
| `Uart1RxBreakErr`                | 14                    | 13                  |
| `Uart1RxTimeout`                 | 15                    | 14                  |
| `Uart1RxParityErr`               | 16                    | 15                  |
| `Uart2TxWatermark`               | 17                    | 16                  |
| `Uart2RxWatermark`               | 18                    | 17                  |
| `Uart2TxEmpty`                   | 19                    | 18                  |
| `Uart2RxOverflow`                | 20                    | 19                  |
| `Uart2RxFrameErr`                | 21                    | 20                  |
| `Uart2RxBreakErr`                | 22                    | 21                  |
| `Uart2RxTimeout`                 | 23                    | 22                  |
| `Uart2RxParityErr`               | 24                    | 23                  |
| `Uart3TxWatermark`               | 25                    | 24                  |
| `Uart3RxWatermark`               | 26                    | 25                  |
| `Uart3TxEmpty`                   | 27                    | 26                  |
| `Uart3RxOverflow`                | 28                    | 27                  |
| `Uart3RxFrameErr`                | 29                    | 28                  |
| `Uart3RxBreakErr`                | 30                    | 29                  |
| `Uart3RxTimeout`                 | 31                    | 30                  |
| `Uart3RxParityErr`               | 32                    | 31                  |
| `SpiDeviceGenericRxFull`         | 65                    | 32                  |
| `SpiDeviceGenericRxWatermark`    | 66                    | 33                  |
| `SpiDeviceGenericTxWatermark`    | 67                    | 34                  |
| `SpiDeviceGenericRxError`        | 68                    | 35                  |
| `SpiDeviceGenericRxOverflow`     | 69                    | 36                  |
| `SpiDeviceGenericTxUnderflow`    | 70                    | 37                  |
| `SpiDeviceUploadCmdfifoNotEmpty` | 71                    | 38                  |
| `SpiDeviceUploadPayloadNotEmpty` | 72                    | 39                  |
| `SpiDeviceUploadPayloadOverflow` | 73                    | 40                  |
| `SpiDeviceReadbufWatermark`      | 74                    | 41                  |
| `SpiDeviceReadbufFlip`           | 75                    | 42                  |
| `SpiDeviceTpmHeaderNotEmpty`     | 76                    | 43                  |
| `I2c0FmtThreshold`               | 77                    | 44                  |
| `I2c0RxThreshold`                | 78                    | 45                  |
| `I2c0FmtOverflow`                | 79                    | 46                  |
| `I2c0RxOverflow`                 | 80                    | 47                  |
| `I2c0Nak`                        | 81                    | 48                  |
| `I2c0SclInterference`            | 82                    | 49                  |
| `I2c0SdaInterference`            | 83                    | 50                  |
| `I2c0StretchTimeout`             | 84                    | 51                  |
| `I2c0SdaUnstable`                | 85                    | 52                  |
| `I2c0CmdComplete`                | 86                    | 53                  |
| `I2c0TxStretch`                  | 87                    | 54                  |
| `I2c0TxOverflow`                 | 88                    | 55                  |
| `I2c0AcqFull`                    | 89                    | 56                  |
| `I2c0UnexpStop`                  | 90                    | 57                  |
| `I2c0HostTimeout`                | 91                    | 58                  |
| `I2c1FmtThreshold`               | 92                    | 59                  |
| `I2c1RxThreshold`                | 93                    | 60                  |
| `I2c1FmtOverflow`                | 94                    | 61                  |
| `I2c1RxOverflow`                 | 95                    | 62                  |
| `I2c1Nak`                        | 96                    | 63                  |
| `I2c1SclInterference`            | 97                    | 64                  |
| `I2c1SdaInterference`            | 98                    | 65                  |
| `I2c1StretchTimeout`             | 99                    | 66                  |
| `I2c1SdaUnstable`                | 100                   | 67                  |
| `I2c1CmdComplete`                | 101                   | 68                  |
| `I2c1TxStretch`                  | 102                   | 69                  |
| `I2c1TxOverflow`                 | 103                   | 70                  |
| `I2c1AcqFull`                    | 104                   | 71                  |
| `I2c1UnexpStop`                  | 105                   | 72                  |
| `I2c1HostTimeout`                | 106                   | 73                  |
| `I2c2FmtThreshold`               | 107                   | 74                  |
| `I2c2RxThreshold`                | 108                   | 75                  |
| `I2c2FmtOverflow`                | 109                   | 76                  |
| `I2c2RxOverflow`                 | 110                   | 77                  |
| `I2c2Nak`                        | 111                   | 78                  |
| `I2c2SclInterference`            | 112                   | 79                  |
| `I2c2SdaInterference`            | 113                   | 80                  |
| `I2c2StretchTimeout`             | 114                   | 81                  |
| `I2c2SdaUnstable`                | 115                   | 82                  |
| `I2c2CmdComplete`                | 116                   | 83                  |
| `I2c2TxStretch`                  | 117                   | 84                  |
| `I2c2TxOverflow`                 | 118                   | 85                  |
| `I2c2AcqFull`                    | 119                   | 86                  |
| `I2c2UnexpStop`                  | 120                   | 87                  |
| `I2c2HostTimeout`                | 121                   | 88                  |
| `SpiHost0Error`                  | 131                   | 89                  |
| `SpiHost0SpiEvent`               | 132                   | 90                  |
| `SpiHost1Error`                  | 133                   | 91                  |
| `SpiHost1SpiEvent`               | 134                   | 92                  |
| `UsbdevPktReceived`              | 135                   | 93                  |
| `UsbdevPktSent`                  | 136                   | 94                  |
| `UsbdevDisconnected`             | 137                   | 95                  |
| `UsbdevHostLost`                 | 138                   | 96                  |
| `UsbdevLinkReset`                | 139                   | 97                  |
| `UsbdevLinkSuspend`              | 140                   | 98                  |
| `UsbdevLinkResume`               | 141                   | 99                  |
| `UsbdevAvEmpty`                  | 142                   | 100                 |
| `UsbdevRxFull`                   | 143                   | 101                 |
| `UsbdevAvOverflow`               | 144                   | 102                 |
| `UsbdevLinkInErr`                | 145                   | 103                 |
| `UsbdevRxCrcErr`                 | 146                   | 104                 |
| `UsbdevRxPidErr`                 | 147                   | 105                 |
| `UsbdevRxBitstuffErr`            | 148                   | 106                 |
| `UsbdevFrame`                    | 149                   | 107                 |
| `UsbdevPowered`                  | 150                   | 108                 |
| UsbdevLinkOutErr                 | 151                   | 109                 |
