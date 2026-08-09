{
	pkgs,
	szy,
	...
}:
let

	hostData = import ./hostData.nix { inherit szy; inherit (pkgs) lib; };

	generateInputs = pkgs.callPackage ./generateInputs.nix { inherit hostData; };

	outputs =
	rec {

		generateFlake = pkgs.callPackage ./generateFlake.nix { inherit hostData generateInputs; };

		partition = pkgs.callPackage ./partition { inherit hostData; };

		bootstrap = pkgs.mkShell
		{

			packages =
			[
				generateFlake
				partition
			];

		};

	};

in
	outputs
