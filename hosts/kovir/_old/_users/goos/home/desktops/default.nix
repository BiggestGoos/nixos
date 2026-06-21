{ osConfig, szy, config, ... }:
{
	
	imports = osConfig."${szy}".desktops.user.import ./.;

}
