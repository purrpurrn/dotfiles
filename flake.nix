# Do not modify! This file is generated.

{
  description = "amateur nix config";
  inputs = {
    ags.url = "github:aylur/ags";
    flake-programs-sqlite = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:wamserma/flake-programs-sqlite";
    };
    flakegen.url = "github:jorsn/flakegen";
    hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    hyprcursor = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hyprwm/hyprcursor";
    };
    hypridle = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hyprwm/hypridle";
    };
    hyprland = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hyprwm/hyprland/e87227e00ae350adebafd2adde95a47e1f68cb3a";
    };
    hyprlock = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hyprwm/hyprlock";
    };
    hyprpicker = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hyprwm/hyprpicker";
    };
    impermanence.url = "github:nix-community/impermanence";
    matugen.url = "github:InioX/matugen";
    niri.url = "github:sodiboo/niri-flake";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin";
    };
    nixlib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim";
    };
    prism.url = "github:IogaMaster/prism";
    schizofox.url = "github:schizofox/schizofox";
    vesktop.url = "github:NixOS/nixpkgs/5607766da72127e8daa6bc58edddf8e4b9506986";
  };
  nixConfig = {
    substituters = [ "https://cache.nixos.org" "https://nix-community.cachix.org" "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    trusted-users = [ "root" "@wheel" ];
  };
  outputs = inputs: inputs.flakegen ./flake.in.nix inputs;
}