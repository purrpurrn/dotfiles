{ config, pkgs, inputs, ... }: {
  config = {
    programs.nix-ld.enable = true;
    environment.systemPackages = [
      inputs.nix-alien.packages."x86_64-linux".nix-alien
    ];
  };
}
