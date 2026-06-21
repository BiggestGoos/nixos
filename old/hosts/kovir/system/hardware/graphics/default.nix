{ pkgs, ... }:
{

	boot.initrd.kernelModules = [ "amdgpu" ];

	hardware.graphics.extraPackages = with pkgs; [ 	
		libvdpau-va-gl
	];

	environment.sessionVariables = { VDPAU_DRIVER = "radeonsi"; LIBVA_DRIVER_NAME = "radeonsi"; };

	hardware.amdgpu = {

		initrd.enable = true;
		opencl.enable = true;

		overdrive = {
			enable = true;
			ppfeaturemask = "0xfffd3fff";
		};

	};

}
