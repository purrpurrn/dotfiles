# Do not modify! This file is generated.

{
  description = "amateur nix config";
  inputs = {
    ags.url = "github:aylur/ags";
    cosmic = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:lilyinstarlight/nixos-cosmic";
    };
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
      url = "git+https://github.com/hyprwm/hyprcursor?submodules=1";
    };
    hypridle = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+https://github.com/hyprwm/hypridle?submodules=1";
    };
    hyprland = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+https://github.com/hyprwm/hyprland?submodules=1";
    };
    hyprlock = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+https://github.com/hyprwm/hyprlock?submodules=1";
    };
    hyprpicker = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+https://github.com/hyprwm/hyprpicker?submodules=1";
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
    nixpak = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nixpak/nixpak";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim";
    };
    prism.url = "github:IogaMaster/prism";
    schizofox.url = "github:schizofox/schizofox";
  };
  nixConfig = {
    extra-trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
    extra-trusted-substituters = [ "https://nix-community.cachix.org" "https://hyprland.cachix.org" "https://cosmic.cachix.org" ];
    trusted-users = [ "root" ];
  };
  outputs = inputs: inputs.flakegen ./flake.in.nix inputs;
}