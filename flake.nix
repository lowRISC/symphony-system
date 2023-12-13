{
  description = "Symphony System";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }: let
    system_outputs = system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      python_check_app = pkgs.writeShellApplication {
        name = "python-check";
        runtimeInputs = with pkgs; [
          ruff
          python311
          python311Packages.mypy
        ];
        text = ''
          ruff format --check .
          ruff check .
          mypy .
        '';
      };
      python_fix_app = pkgs.writeShellApplication {
        name = "python-fix";
        runtimeInputs = [pkgs.ruff];
        text = ''
          ruff format .
          ruff check --fix .
        '';
      };
    in {
      formatter = pkgs.alejandra;
      apps.python_check = {
        type = "app";
        program = "${python_check_app}/bin/python-check";
      };
      apps.python_fix = {
        type = "app";
        program = "${python_fix_app}/bin/python-fix";
      };
    };
  in
    flake-utils.lib.eachDefaultSystem system_outputs;
}
