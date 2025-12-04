{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    mrtnvgr = {
      url = "github:mrtnvgr/nurpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    margesimpson = {
      url = "github:mrtnvgr/margesimpson";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      flake.homeModules.default = import ./module inputs;
    };
}
