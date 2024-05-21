{ config, inputs, lib, options, ... }: {
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  config = {
    users.mutableUsers = false;

    fileSystems = {
      "/" = lib.mkIf (options.environment.persistence.tmpfs.enable) (
        lib.mkForce {
	  device = "tmpfs";
	  fsType = "tmpfs";
	  options = [
	    "defaults"
	    "size=4G"
	    "mode=755"
	  ];
	}
      );
    };

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
