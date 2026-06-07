{ szy, lib, config, pkgs, system, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "desktopEntry";
	enable = true;

	parameters =
	{ final, object }:
	{

		desktopEntry =
		{

			final =
			let
	
				inherit (final.data) desktopEntry;
				inherit (desktopEntry) required base;

				baseOverrides = desktopEntry.overrides;
				overrides = 
				lib.attrsets.filterAttrs 
				(
					name: value:
						value != null
				)
				baseOverrides;

				baseValues = base.values // overrides;

				values = 
				let
					fullSet =
					base: override: szy.utils.mergeAll [ base override ];

					fullActions = fullSet (base.values.actions or {}) (overrides.actions or {});
					fullExtra = fullSet (base.values.extraConfig or {}) (overrides.extraConfig or {});
				in
				baseValues //
				{
					name = baseValues.name or "generated+${final.meta.template}-${final.meta.name}";
					actions = fullActions;
					extraConfig = fullExtra;
				};

				result = 
				if (baseValues == {})
				then (lib.trivial.throwIf required "The required desktop entry for definition \"${final.meta.name}\" of template \"${final.meta.template}\" could not be created.") null
				else "${pkgs.makeDesktopItem (values)}/share/applications/${values.name}.desktop";

			in
			{		
	
				path = 
				lib.options.mkOption
				{
					type = if (required) then lib.types.str else lib.types.nullOr lib.types.str;
					readOnly = true;
					default = result;
				};

				values = lib.options.mkOption
				{
					type = lib.types.attrs;
					readOnly = true;
					default = values;
				};
			
			};

			base = 
			{

				path = lib.options.mkOption
				{
					type = lib.types.nullOr lib.types.str;
					default = final.meta.name;
				};

				values = lib.options.mkOption
				{
					type = lib.types.attrs;
					readOnly = true;
					default = 
					let

						base = final.data.desktopEntry.base.path;
						path = if (lib.strings.hasInfix "/" base) then base else "${final.data.package}/share/applications/${base}.desktop";
						pathExists = if (base == null) then false else builtins.pathExists path;

						raw = builtins.readFile path;

						fileName = builtins.head (builtins.match ".*/([^/]*).desktop" path);

						nameKeys =
						{
							Type = "type";
							Name = "desktopName";
							GenericName = "genericName";
							NoDisplay = "noDisplay";
							Comment = "comment";
							Icon = "icon";
							OnlyShowIn = "onlyShowIn";
							NotShowIn = "notShowIn"; 
							DBusActivatable = "dbusActivatable";
							TryExec = "tryExec";
							Exec = "exec";
							Path = "path";
							Terminal = "terminal";
							MimeType = "mimeTypes";
							Categories = "categories";
							Implements = "implements";
							Keywords = "keywords";
							StartupNotify = "startupNotify";
							StartupWMClass = "startupWMClass";
							URL = "url";
							PrefersNonDefaultGPU = "prefersNonDefaultGPU";
						};
						names = builtins.attrNames nameKeys;

						keyIsList =
						[
							"onlyShowIn"
							"notShowIn"
							"mimeTypes"
							"categories"
							"implements"
							"keywords"
						];

						keyIsBool =
						[
							"noDisplay"
							"dbusActivatable"
							"terminal"
							"startupNotify"
							"prefersNonDefaultGPU"
						];

						splitRaw = builtins.split "\n[[]Desktop Action ([^\n]*)[]][ ]*\n" raw;

						splitRows = 
						list: 
						builtins.filter 
						(
							value: 
								value != [] && 
								value != "" && 
								!(lib.strings.hasPrefix "#" value) &&
								!(lib.strings.hasPrefix "[" value)
						) 
						(
							builtins.split "\n" list
						);

						mainRows = splitRows (builtins.head splitRaw);

						actionNames = 
						builtins.filter
						(
							value:
								value != null
						)
						(
							builtins.map 
							(
								row: 
									if !(builtins.isList row)
									then null
									else builtins.head row
							) 
							splitRaw
						);

						splitAction = action: data: builtins.filter (value: value != []) (builtins.split "\n[[]Desktop Action ${action}[]][ ]*\n" data);

						rawActionSplits = 
						lib.lists.drop (if ((builtins.length actionNames) == 1) then 0 else 1)
						(lib.lists.foldl
						(
							list: action: 
							let
								isFirst = action == (builtins.head actionNames);
								isLast = action == (lib.lists.last actionNames);

								data = 
								if (isFirst)
								then raw
								else lib.lists.last (lib.lists.last list);

								split = splitAction action data;
							in
								list ++ [ split ]
						) 
						[]
						actionNames);

						actionsRows =
						let
							end = (builtins.length actionNames) - 1;
						in
						builtins.listToAttrs
						(
							builtins.map
							(
								i:
								let
									action = builtins.elemAt actionNames i;
									value = 
									if (i != end)
									then builtins.head (builtins.elemAt rawActionSplits i)
									else lib.lists.last (lib.lists.last rawActionSplits);
								in
								{
									name = action;
									value = splitRows value;
								}
							)
							(lib.lists.range 0 end)
						);

						parseRows = 
						isAction: rows:
						let
							keyValue = 
							builtins.listToAttrs
							(
								builtins.map
								(
									row:
									let
										name = builtins.head (builtins.match "([^=]*)=.*" row);
										value = builtins.head (builtins.match "[^=]*=(.*)" row);
									in
									{
										inherit name value;
									}
								)
								rows
							);

							removeExtra =
							lib.attrsets.filterAttrs 
							(
								name: value:
									(builtins.elem name names)
							)
							keyValue;

							extra =
							lib.attrsets.filterAttrs 
							(
								name: value:
									!(builtins.elem name names)
							)
							keyValue;

							mappedKeys =
							lib.attrsets.mapAttrs'
							(
								name: value:
								let
									mappedName = nameKeys."${name}";
								in
								{
									name = if (mappedName == "desktopName" && isAction) then "name" else mappedName; # In actions it's called name and not desktopName
									value =
									let
										# String values (which all lists are) can only contain ASCII values (according to spec). We use this to escape "\;".
										temp = builtins.replaceStrings [ ''\;'' ] [ "¤" ] value;
										split = builtins.filter (value: value != "") (lib.strings.splitString ";" temp);
										result = builtins.map (value: builtins.replaceStrings [ "¤" ] [ ''\;'' ] value) split;
									in
									if (builtins.elem mappedName keyIsList)
									then result
									else if (builtins.elem mappedName keyIsBool)
									then builtins.fromJSON value
									else value;
								}
							)
							removeExtra;
							
							result = 
							if (isAction)
							then mappedKeys
							else mappedKeys //
							{
								name = fileName;
								extraConfig = extra;
							};

						in
							result;

						main = parseRows false mainRows;
						actions =
						lib.attrsets.mapAttrs
						(
							name: value:
								parseRows true value
						)
						actionsRows;

						result =
						main //
						{
							inherit actions;
						};

					in
						if (pathExists) then result else {};
				};

			};

			overrides =
			let
				string = lib.types.str;
				list = lib.types.listOf lib.types.str;
				bool = lib.types.bool;
				keys = 
				{
					type = string;
					desktopName = string;
					genericName = string;
					noDisplay = bool;
					comment = string;
					icon = string;
					onlyShowIn = list;
					notShowIn = list; 
					dbusActivatable = bool;
					tryExec = string;
					exec = string;
					path = string;
					terminal = bool;
					mimeTypes = list;
					categories = list;
					implements = list;
					keywords = list;
					startupNotify = bool;
					startupWMClass = string;
					url = string;
					prefersNonDefaultGPU = bool;
				};
			in
			(
				lib.attrsets.mapAttrs
				(
					name: value:
					lib.options.mkOption
					{
						type = lib.types.nullOr value;
						default = null;
					}
				)
				keys
			) //
			{

				extraConfig = lib.options.mkOption
				{
					type = lib.types.nullOr (lib.types.attrsOf lib.types.str);
					default = null;
				};

				actions = lib.options.mkOption
				{
					type = lib.types.nullOr (lib.types.attrsOf (lib.types.submoduleWith { modules = [ { options =
					{

						name = lib.options.mkOption
						{
							type = lib.types.nullOr lib.types.str;
							default = null;
						};

						exec = lib.options.mkOption
						{
							type = lib.types.nullOr lib.types.str;
							default = null;
						};

						icon = lib.options.mkOption
						{
							type = lib.types.nullOr lib.types.str;
							default = null;
						};

					}; } ]; }));
					default = null;
				};

			};

			required = lib.options.mkOption
			{
				type = lib.types.bool;
				default = false;
			};

		};

	};

}
