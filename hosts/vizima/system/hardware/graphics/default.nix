{ pkgs, ... }:
{

	hardware.graphics = 
	let

		packages = 
		with pkgs; 
		[ 
			intel-media-driver
			# This supports 11th Gen
			intel-compute-runtime-legacy1
		
			libvdpau-va-gl
		];

	in
	{
		enable = true;
		enable32Bit = true;

		extraPackages = packages;
		extraPackages32 = packages;
	};

	environment.sessionVariables = 
	{ 
		VDPAU_DRIVER = "va_gl"; 
		LIBVA_DRIVER_NAME = "iHD"; 
	};

}
