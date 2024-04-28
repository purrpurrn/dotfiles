{ config, pkgs, inputs, lib, ... }: {
  options.services.onepassword.enable = lib.mkEnableOption "onepassword";

  config = lib.mkIf (config.services.onepassword.enable) {
    programs._1password-gui.enable = lib.mkDefault true;
    programs._1password-gui.polkitPolicyOwners = lib.mkDefault [ "mew" ];
    programs._1password.enable = lib.mkDefault true;
  };
}
