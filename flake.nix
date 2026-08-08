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

		__functor = self: hostname: inputs': { metaData ? {}, modules ? [] }:
		let

			finalInputs = inputs // inputs';

			inherit (finalInputs) nixpkgs;
			inherit (nixpkgs) lib;

			hostFolder = ./hosts;

			hostPath = hostFolder + "/${hostname}";

			defaultMetaData = lib.trivial.importJSON (hostPath + "/data.meta");
			finalMetaData = defaultMetaData // (metaData);

		in
		mkFlake
		{
			inputs = finalInputs;
			szy = szy.addArguments
			{ 
				flake =
				{
					inherit (finalMetaData) root;
				};
				host =
				{
					name = hostname;
					path = hostPath;
					inherit (finalMetaData) system;
				};
			};
			inherit hostname modules;
		};

	};

}
