{ szy, config, lib, ... }:
{

	options."${szy}".desktops.options.applications = {

		

		applications = lib.mkOption {

			type = lib.types.attrsOf (lib.types.submoduleWith { modules = [ ({
				options = {
					command = lib.mkOption {
						type = lib.types.str;
					};
					desktopEntry = lib.mkOption {
						type = lib.types.nullOr lib.types.str;
						default = null;
					};
				};
			}) ]; });
		};
	};

	config."${szy}".desktops.options.applications.applications = {

		browser = 
		let
			default = config."${szy}".browsers.defaultValues;
		in
		{
			command = lib.mkDefault default.command;
			desktopEntry = lib.mkDefault default.desktopEntry;
		};

	};

}
