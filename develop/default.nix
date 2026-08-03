{
	pkgs,
	mkShell,
	...
}:
let

	reloadFlake = pkgs.callPackage ./reloadFlake.nix { };

in
mkShell
{

	packages =
	[
		pkgs.git
		pkgs.onefetch

		reloadFlake
	];

}
