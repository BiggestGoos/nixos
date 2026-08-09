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

		deployFlake = pkgs.callPackage ./deployFlake.nix { inherit hostData; };

		generateFlake = pkgs.callPackage ./generateFlake.nix { inherit hostData generateInputs; };

		partition = pkgs.callPackage ./partition { inherit hostData; };

		bootstrap = pkgs.mkShell
		{

			packages =
			[
				deployFlake
				generateFlake
				partition
			];

		};

	};

in
	outputs
