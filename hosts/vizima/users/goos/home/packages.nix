{ szy, pkgs, ... }:
{

	"${szy}".objects.package.definitions =
	{
		starship.data.enable = true;
	};

	home.packages =
	with pkgs;
	[
		python314
	];

}
