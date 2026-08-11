{

	inputs = 
	{
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-parts.url = "github:hercules-ci/flake-parts";
		szy.url = "github:BiggestGoos/szy-nixos";
	};

	outputs = 
	{ ... }@inputs:
	let

		mkFlake = import ./flake/make.nix;

		szy = (inputs.szy.library).addArguments
		{ 
			root = inputs.self.outPath;
		};

	in
	szy.lib.attrsets.deepMerge
	(
		inputs.flake-parts.lib.mkFlake { inherit inputs; }
		{

			systems =
			[
				"x86_64-linux"
			];

			perSystem = 
			{ 
				pkgs,
				...
			}:
			{
				packages = import ./flake/packages.nix { inherit pkgs szy; };
			};

		}
	)
	{

		__functor = self: hostname: inputs': data:
		let

			finalInputs = inputs // inputs';

			inherit (finalInputs) nixpkgs;
			inherit (nixpkgs) lib;

			hostFolder = ./hosts;

			hostPath = hostFolder + "/${hostname}";

		in
		mkFlake
		{
			inputs = finalInputs;
			szy = szy.addArguments
			{ 
				flake =
				{
					inherit (data.metaData) root;
				};
				host =
				{
					name = hostname;
					path = hostPath;
					inherit (data.metaData) system;
				};
			};
			inherit hostname;
			modules = data.modules or [];
		};

	};

}
