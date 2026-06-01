{ identifier, lib, utils, importLib, helper, ... }@gInputs:
{

	composable =
	{
		components, # { <component-name> = { path (absolute or relative (componentPath needs to be set)), enable. }; }
		componentPath ? null,
	}:
	config:
	let

		evaluatedComponents = 
		lib.attrsets.mapAttrs 
		(
			name: value:
			{
				enable = lib.mkDefault value.enable;
				path = if (builtins.isPath value.path) then value.path else (componentPath + "/${value.path}");
			}
		) components;

	in
	definitionData:
	let

		metaData = 
		let
			templateNamespace = [ "options" ] ++ helper.namespaces.templates;
			definitionNamespace = templateNamespace ++ [ template helper.prefixes.definitions ];
			template = builtins.head (builtins.attrNames (utils.options.getFromKeys { keys = templateNamespace; object = definitionData; }));
			name = builtins.head (builtins.attrNames (utils.options.getFromKeys { keys = definitionNamespace; object = definitionData; }));
		in
		{
			inherit template name;
		};

		namespace = helper.namespaces.templates ++ [ metaData.template helper.prefixes.definitions metaData.name ];

		definition = helper.getDefinition ({ inherit config; } // metaData);

	in
	utils.mergeAll 
	[
		definitionData

		{

			imports =
			let

				toggledComponents = lib.attrsets.mapAttrsToList
				(name: value:
				let
					enabled = definition.data.components."${name}".enable;
				in
					lib.lists.last (gInputs.importLib.mkToggleable enabled (lib.lists.toList value.path))
				) evaluatedComponents;

			in
			[

				(utils.options.createFromKeys { keys = namespace; value =
				{

					data.components = evaluatedComponents;
				
					meta.extends = [ "composable" ];

				}; })

			] ++ toggledComponents;

		}

	];

}
