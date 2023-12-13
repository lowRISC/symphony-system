# Symphony system

Symphony is a system for evaluating the usage of [CHERIoT Ibex core](https://github.com/microsoft/cheriot-ibex) as a microcontroller for embedded, IoT and Operational Technology applications that require the use of a root of trust
The system is an integration of a [Sonata system](https://github.com/lowRISC/sonata-system) (containing a [CHERIoT Ibex core](https://github.com/microsoft/cheriot-ibex)) with [OpenTitan Earl Grey](https://github.com/lowRISC/opentitan)
It is designed for use on FPGA and specifically targets the [Sonata FPGA board](./doc/architecture/board.md).

The system is at its architectural definition and specification stage.
RTL development has yet to begin.
In the meantime, please read the [architecture specfication](./doc/architecture/intro.md).

Symphony is part of the [Sunburst Project](https://www.sunburst-project.org) funded by [UKRI](https://www.ukri.org/) / [DSbD](https://www.dsbd.tech/).

## Contributing
### Installing Nix

The Nix package manager is used to create reproducible builds and consistent development environments.
Follow the instructions on [the official download page](https://nixos.org/download.html) to install the Nix package manager.

### Building Documentation

The documentation uses [mdBook](https://rust-lang.github.io/mdBook/) see the [installation guide](https://rust-lang.github.io/mdBook/guide/installation.html) for further details on installation.

Once mdBook is installed the documentation can be built and viewed with:

```sh
mdbook serve --open
```

### Code Quality

To check the python code run:

```sh
nix run .#python_check
```

To automatically fix some lints and formats use:

```sh
nix run .#python_fix
```

To automatically format Nix files use:

```sh
nix fmt
```

## License

Unless otherwise noted, everything in the repository is covered by the [Apache License](https://www.apache.org/licenses/LICENSE-2.0.html), Version 2.0. See the [LICENSE](https://github.com/lowRISC/symphony-system/blob/main/LICENSE) file for more information on licensing.
