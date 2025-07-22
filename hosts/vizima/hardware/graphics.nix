{ pkgs, ... }:
{

	hardware.graphics.enable = true;
	hardware.graphics.enable32Bit = true;

	hardware.graphics.extraPackages = with pkgs; [ 
		intel-media-driver
		# This supports 11th Gen
		intel-compute-runtime-legacy1
		
		libvdpau-va-gl

		mesa
	];

	environment.sessionVariables = { VDPAU_DRIVER = "va_gl"; LIBVA_DRIVER_NAME = "iHD"; };

}
