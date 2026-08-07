{

	inputs = 
	{

		flake-parts.url = "github:hercules-ci/flake-parts";
		szy.url = "github:BiggestGoos/szy-nixos";

	};

	outputs = 
	{ ... }@inputs:
	let

		mkFlake = import ./flake/make.nix;

	in
	{

		__functor = self: hostname: inputs': data:
		let

			finalInputs = inputs // inputs';

			inherit (finalInputs) nixpkgs;
			inherit (nixpkgs) lib;

			hostFolder = ./hosts;

			hostPath = hostFolder + "/${hostname}";

			defaultMetaData = lib.trivial.importJSON (hostPath + "/data.meta");
			finalMetaData = defaultMetaData // (data.metaData or {});

			szy = (inputs.szy.library).addArguments
			{ 
				root = inputs.self.outPath;
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

		in
		inputs.flake-parts.lib.mkFlake { inputs = inputs'; }
		{

			flake = mkFlake
			{
				inputs = finalInputs;
				inherit szy hostname;
				inherit (data) modules;
			};

			systems =
			[
				finalMetaData.system
			];

			perSystem = 
			{ 
				pkgs,
				...
			}:
			{
				packages = import ./flake/packages.nix { inherit pkgs szy; };
			};

		};

	};

}
