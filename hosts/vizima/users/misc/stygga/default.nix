{ pkgs, ... }:
{

	users = {

		groups.stygga = {};

		users = {

			goos.extraGroups = [ "libvirtd" "stygga" ];

		};

	};

	environment = {
    	systemPackages = [ 
    		(pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        	qemu-system-x86_64 \
        	-bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
        	"$@"
      		'')
    	];
    };

	programs.virt-manager.enable = true;

	virtualisation = {

		libvirtd.enable = true;

	};

}
