{ pkgs, ... }:
{

	# Override the plymouth package to use my fork which enables shortcuts for rebooting and shutting down while booting
	nixpkgs.config.packageOverrides = pkgs:
	{
		plymouth = (pkgs.plymouth.overrideAttrs (oldAttrs: {
			src = builtins.fetchurl {
				url = "https://github.com/BiggestGoos/plymouth-fork/archive/refs/tags/release3.tar.gz";
				sha256 = "0fimhs4vlb7mvj837f7nqlijbpx73mvi55wiavv2ri3qff7qqgcq";
			};
    	}));

	};

	boot = {

    	kernelParams = [
			"plymouth.use_simpledrm"
    	];

       	plymouth = { 
			
			enable = true;
    		font = "${pkgs.hack-font}/share/fonts/truetype/Hack-Regular.ttf";
    		logo = "${pkgs.nixos-icons}/share/icons/hicolor/128x128/apps/nix-snowflake.png";

    		extraConfig = "UseFirmwareBackground=false";
		
		};

	};

}
