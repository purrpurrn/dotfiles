{ config, pkgs, inputs, lib, ... }: {
  imports = [
    inputs.home-manager.nixosModule
  ];

#  options.users.users = with lib; {
#    persistence.directories = mkOption {
#      type = with types; attrsOf (submodule ({ name, config, ... }: { options = name; }));
#      default = null;
#      example = {
#        users.users.alice.persistence = [
#   	  ".mozilla"
#	  "Pictures"
#	  "Documents/Projects"
#        ];
#     };
#     description = ''
#        allows user to specify directories in the home directory.
#      '';
#    };
#  };

  config = {
    users.users = {
      mew = {
        uid = 1001;
        isNormalUser = true;
        home = "/home/mew";
        hashedPassword = "$y$j9T$4hemAQtx7ejdYLhw6yohh/$YO.M0SV7GCOF1fqGGZOXQhxA6lFemZxjZdPzXrTttf0";
        extraGroups = [
          "wheel"
  	  "video"
	  "syncthing"
        ];
     };
  };

      home-manager = {
        extraSpecialArgs = inputs // { inherit inputs; };
        useGlobalPkgs = true;

        users = {
          mew = { ... }: {
            imports = [ 
	      ./mew 
	    ];
        };
      };
    };
  };
}
