{
	pkgs,
	szy,
	...
}:
{

	generateInputs = pkgs.callPackage ./generateInputs.nix { inherit szy; };
	#generateFlake = pkgs.callPackage ./generateFlake.nix { inherit szy; };

}
