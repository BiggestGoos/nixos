{ szy, lib, config, osConfig, ... }:
{

	config."${szy}".desktops.options.actions.actions = szy.utils.mergeAll [ {

		category.programs = {

			set = {

				browser = 
				let
					default = config."${szy}".browsers.defaultValues;
				in
				lib.mkDefault
				{
					inherit (default) command desktopEntry;
				};

			};

		};

	} ];

}
