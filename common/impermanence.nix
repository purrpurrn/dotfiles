{ config, inputs, lib, ... }: {
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  config = {
    users.mutableUsers = false;

    # Sudo doesn't stop lecturing the user because impermanence coincidentally infects `sudo` with dementia
    security.sudo.extraConfig = "Defaults lecture=never";

    environment.persistence = {
      "/persist" = {
        hideMounts = true;
	files = [ "/etc/machine-id" ] ++ config.environment.persistence.files;
	directories = [ "/var/log" ] ++ config.environment.persistence.directories;
      };
    };
  };  
}
