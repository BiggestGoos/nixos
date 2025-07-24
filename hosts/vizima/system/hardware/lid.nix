{ ... }:
{

	# https://wiki.nixos.org/wiki/Laptop

	services.logind.lidSwitch = "suspend-then-hibernate";
	services.logind.lidSwitchExternalPower = "suspend-then-hibernate";
	services.logind.lidSwitchDocked = "suspend-then-hibernate";

}
