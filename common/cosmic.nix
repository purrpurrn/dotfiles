{ config, pkgs, inputs, lib, ... }: {
  imports = [
    inputs.cosmic.nixosModules.default
  ];
   
  config = {
    services.desktopManager.cosmic.enable = true;
    services.displayMnager.cosmic-greeter.enable = true;
  };
};
