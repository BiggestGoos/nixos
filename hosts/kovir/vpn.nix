{ pkgs, ... }:
{

	environment.systemPackages = 
	[ 
		pkgs.proton-vpn 
		pkgs.mullvad-vpn
		pkgs.mullvad-compass
	];

	services.mullvad-vpn =
	{
		enable = true;
	};

}
