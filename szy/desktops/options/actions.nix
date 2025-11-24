{ szy, config, lib, ... }:
{

	options."${szy}".desktops.options.actions =
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

				actions = config."${szy}".desktops.options.actions.actions;

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

}
