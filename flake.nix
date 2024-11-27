{
  description = "Teaching";

  inputs = {
    nix2container = {
      url = "github:nlewo/nix2container";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    laas-beamer-theme = {
      url = "git+https://gitlab.laas.fr/gsaurel/laas-beamer-theme";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.treefmt-nix.flakeModule ];
      systems = [ "x86_64-linux" ];
      perSystem =
        {
          config,
          pkgs,
          self',
          system,
          ...
        }:
        {
          devShells = {
            default = pkgs.mkShell {
              nativeBuildInputs = [ config.treefmt.build.wrapper ];
              inputsFrom = [ self'.packages.default ];
              packages = [
                pkgs.git
                pkgs.openssh
                pkgs.pdfpc
                pkgs.watchexec
              ];
            };
            bash = self'.devShells.default.overrideAttrs (super: {
              nativeBuildInputs = super.nativeBuildInputs ++ [
                pkgs.coreutils
                pkgs.bashInteractive
                pkgs.gnugrep
                pkgs.gnumake
              ];
            });
          };
          packages = {
            default = pkgs.callPackage ./default.nix {
              laas-beamer-theme = inputs.laas-beamer-theme.packages.${system}.default;
            };
            container = inputs.nix2container.packages.${system}.nix2container.buildImage {
              name = "gitlab.laas.fr:4567/gsaurel/teach";
              tag = "latest";
              config = {
                entrypoint = [ (pkgs.lib.getExe pkgs.bashInteractive) "-c" ];
                Env = [
                  "PATH=${pkgs.lib.makeBinPath (self'.devShells.bash.nativeBuildInputs ++ [ pkgs.bashInteractive ])}"
                ];
              };
              copyToRoot = self'.devShells.bash;
              maxLayers = 120;
            };
            docker = pkgs.dockerTools.buildNixShellImage {
              name = "gitlab.laas.fr:4567/gsaurel/teach";
              tag = "latest";
              drv = self'.devShells.default;
            };
          };
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              deadnix.enable = true;
              nixfmt-rfc-style.enable = true;
              ruff = {
                check = true;
                format = true;
              };
            };
          };
        };
    };
}
