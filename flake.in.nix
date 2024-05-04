{
  description = "amateur nix config";

  inputs = let
    dep = url: { inherit url; inputs.nixpkgs.follows = "nixpkgs"; };
  in {
    # nixpkgs
    nixlib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    vesktop.url = "github:NixOS/nixpkgs/5607766da72127e8daa6bc58edddf8e4b9506986";

    # Required Flake for impermanence.
    impermanence.url = "github:nix-community/impermanence";

    # command-not-found workaround.
    flake-programs-sqlite = (dep "github:wamserma/flake-programs-sqlite");

    # Support for `/home` and improved MacOS support.
    nix-darwin = (dep "github:LnL7/nix-darwin");
    home-manager = (dep "github:nix-community/home-manager");

    # hyprland ecosystem.
    hyprland = (dep "github:hyprwm/hyprland/e87227e00ae350adebafd2adde95a47e1f68cb3a");
    hyprlock = (dep "github:hyprwm/hyprlock");
    hypridle = (dep "github:hyprwm/hypridle");
    hyprcursor = (dep "github:hyprwm/hyprcursor");
    hyprpicker = (dep "github:hyprwm/hyprpicker");

    # misc.
    schizofox.url = "github:schizofox/schizofox";
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim = (dep "github:nix-community/nixvim");
    prism.url = "github:IogaMaster/prism";
    ags.url = "github:aylur/ags";
    hardware.url = "github:NixOS/nixos-hardware";
    niri.url = "github:sodiboo/niri-flake";
    matugen.url = "github:InioX/matugen";
  };

  nixConfig = {
    trusted-users = [ "root" "@wheel" ];

    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      nos = nixpkgs.lib.nixosSystem {
        modules = [ 
	  ./hosts/nos 
	  ./devices/15s-eq0564ng
	  ./home/users.nix
	];
        specialArgs = { inherit inputs; };
      };
    };
  };

}
