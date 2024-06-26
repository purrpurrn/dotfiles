{
  description = "amateur nix config";

  inputs = let
    dep = url: { inherit url; inputs.nixpkgs.follows = "nixpkgs"; };
  in {
    # nixpkgs
    nixlib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Required Flake for impermanence.
    impermanence.url = "github:nix-community/impermanence";

    # command-not-found workaround.
    flake-programs-sqlite = (dep "github:wamserma/flake-programs-sqlite");

    # Support for `/home` and improved MacOS support.
    nix-darwin = (dep "github:LnL7/nix-darwin");
    home-manager = (dep "github:nix-community/home-manager");

    # hyprland ecosystem.
    hyprland = (dep "git+https://github.com/hyprwm/hyprland?submodules=1");
    hyprlock = (dep "git+https://github.com/hyprwm/hyprlock?submodules=1");
    hypridle = (dep "git+https://github.com/hyprwm/hypridle?submodules=1");
    hyprcursor = (dep "git+https://github.com/hyprwm/hyprcursor?submodules=1");
    hyprpicker = (dep "git+https://github.com/hyprwm/hyprpicker?submodules=1");

    # misc.
    schizofox.url = "github:schizofox/schizofox";
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim = (dep "github:nix-community/nixvim");
    prism.url = "github:IogaMaster/prism";
    ags.url = "github:aylur/ags";
    hardware.url = "github:NixOS/nixos-hardware";
    niri.url = "github:sodiboo/niri-flake";
    matugen.url = "github:InioX/matugen";
    nixpak = (dep "github:nixpak/nixpak");
    cosmic = (dep "github:lilyinstarlight/nixos-cosmic");
    stylix.url = "github:danth/stylix";
  };

  nixConfig = {
    trusted-users = [ "root" ];

    extra-trusted-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://cosmic.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };

  outputs = { 
    self, 
    nixpkgs,
    nixvim,
    ...
  } @inputs: let 
    # A function that provides a system-specific Nixpkgs for the desired systems
    forAllSystems = f: nixpkgs.lib.genAttrs [ 
      "x86_64-linux" 
      "aarch64-linux" 
      "x86_64-darwin" 
      "aarch64-darwin" 
    ] (system: f {
      pkgs = import nixpkgs { inherit system; };
    });
  in {
    inherit (nixpkgs) lib;

    nixosConfigurations = import ./hosts { inherit inputs; };

    packages = forAllSystems ({ pkgs }: {
      mew.nvim = nixvim.legacyPackages."${pkgs.system}".makeNixvimWithModule {
        module = import ./home/mew/applications/neovim;
      };
    });
  };
}
