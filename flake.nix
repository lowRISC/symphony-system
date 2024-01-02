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
        name = "lint-python";
        runtimeInputs = with pkgs; [
          ruff
          python311
          python311Packages.mypy
        ];
        text = ''
          if [ "''${1:-}" == "fix" ]
          then
            echo "Fixing Python"
            ruff format .
            ruff check --fix .
          else
            echo "Checking Python"
            ruff format --check .
            ruff check .
            mypy .
          fi
        '';
      };
    in {
      formatter = pkgs.alejandra;
      apps.lint_python = {
        type = "app";
        program = "${python_check_app}/bin/lint-python";
      };
    };
  in
    flake-utils.lib.eachDefaultSystem system_outputs;
}
