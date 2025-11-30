{ osConfig, szy, config, ... }:
{
	
	imports = osConfig."${szy}".desktops.import ./.;

}
