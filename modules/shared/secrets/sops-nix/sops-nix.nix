{ inputs, szy, ... }:
if (szy.data.configType == "system")
then
{

	imports =
	[
		inputs.sops-nix.nixosModules.sops
	];

}
else if (szy.data.configType == "user")
then
{

	imports =
	[
		inputs.sops-nix.homeManagerModules.sops
	];

}
else
{}
