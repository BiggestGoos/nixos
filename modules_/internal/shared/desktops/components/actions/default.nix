{ szy, config, lib, ... }:
{

	options."${szy}".desktops.components.actions =
	let

		actionTemplate.options = {
			command = lib.mkOption {
				type = lib.types.either (lib.types.str) (lib.types.functionTo lib.types.str);
			};
			desktopEntry = lib.mkOption {
				type = lib.types.nullOr lib.types.str;
				default = null;
			};
		};

		template.options = {

			set = lib.mkOption {
				type = lib.types.nullOr (lib.types.attrsOf (lib.types.submoduleWith { modules = [ actionTemplate ]; }));
				default = null;
			};

			category = lib.mkOption {
				type = lib.types.nullOr (lib.types.attrsOf (lib.types.submoduleWith { modules = [ template ]; }));
				default = null;
			};

		};

	in
	{

		actions = lib.mkOption {
			type = lib.types.submoduleWith { modules = [ template ]; };
			default = {};
		};

		resolved = lib.mkOption {
			type = lib.types.attrs;
			readOnly = true;
			default = 
			let

				actions = config."${szy}".desktops.components.actions.actions;

				resolveCategory = category:
				let
					categories = if (category != null) then builtins.attrNames category else [];
					sets = builtins.listToAttrs (builtins.map (name: 
					{
						name = name;
						value = 
						let
							innerSets = resolveCategory category."${name}".category;
						in
							szy.utils.mergeAllConflict [ category."${name}".set innerSets ];
					}
					) categories);
				in
					sets;

			in
				szy.utils.mergeAllConflict [ actions.set (resolveCategory actions.category) ];
		};

	};

	config."${szy}".desktops.components.actions.actions.category.programs.category.default.category = 
	let
		programs = config."${szy}".programs;
	in
		lib.attrsets.mapAttrs (name: value: 
		let
			inherit (value) guiAndCli;

			setValues = values: 
			lib.mkIf (values != null)
			{
				open = (lib.mkDefault
				{
					inherit (values) command desktopEntry;
				});

				openGraphical = (lib.mkDefault
				{
					command = values.commandGraphical or values.command;
					inherit (values) desktopEntry;
				});
			};

		in
		if (guiAndCli == false) then {

			set = setValues value.default.values;

		} else {

			category = {

				gui = lib.mkIf (value.default.gui.values != null) { set = setValues value.default.gui.values; };
				cli = lib.mkIf (value.default.cli.values != null) { set = setValues value.default.cli.values; };

			};

		}) programs;

}
