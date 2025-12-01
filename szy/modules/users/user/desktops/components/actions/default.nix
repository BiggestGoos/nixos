{ szy, config, lib, ... }:
{

	imports = [
		(szy.utils.import.internal.shared.from "desktops/components/actions")
	];


	config."${szy}".desktops.components.actions.actions = szy.utils.mergeAll [ {

		category.programs = {

			set = {

				browser = 
				let
					default = config."${szy}".programs.browser.default.values;
				in
				lib.mkDefault
				{
					inherit (default) command desktopEntry;
				};

			};

		};

	} ];

}
