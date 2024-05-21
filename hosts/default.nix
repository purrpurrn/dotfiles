{ inputs, ... }: let
  inherit (inputs) self;
  inherit (self) lib;
in {
  nos = lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ 
      ./nos 
      ../devices/15s-eq0564ng
      ../home/users.nix
    ];
    specialArgs = { inherit lib inputs self; };
  };
}

