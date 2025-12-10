{ self, lib }:
{

	mkConfiguration =
	{ hostname, timeZone, locale, rawRoot }:
	let
		szy = self { inherit hostname rawRoot; };
		inherit (szy) config;
	in
	{

		"${hostname}" = lib.nixosSystem 
		{

			specialArgs = { inherit (self) inputs; inherit szy; };
			modules = [ szy.utils.import.modules.path ] ++ [
				(szy.utils.fromRoot "hosts/${hostname}")
				self.inputs.home-manager.nixosModules.home-manager
				{
					home-manager = 
					{
						useGlobalPkgs = true;
	    				useUserPackages = true;
						backupFileExtension = "backup";
	    				users = builtins.mapAttrs (name: value: (import value.path)) config."${szy}".users.homeManagerPaths;
						extraSpecialArgs = { inherit (self) inputs; inherit szy; };
						sharedModules = [ szy.utils.import.modules.users.user.path ];
					};
				}
			] ++ [ {

				"${szy}" = {

					inherit timeZone locale;

				};

			} ];

		};

	};

}
