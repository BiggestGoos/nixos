{
	pkgs,
	szy,
	...
}:
{

	generateFlake = pkgs.callPackage ./generateFlake.nix { inherit szy; };

}
