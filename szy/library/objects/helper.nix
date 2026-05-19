{ identifier, lib, utils, ... }:
let

	prefixes = {

		objects = "objects";
		templates = "templates";
		definitions = "definitions";

	};

	namespaces = {

		templates = with prefixes; [ identifier objects ];
		definitions = with prefixes; [ identifier objects ];

	};

	getTemplate =
	{
		config,
		name,
	}:
	let
		namespace = namespaces.templates ++ lib.lists.toList name;

		template = utils.options.getFromKeys { keys = namespace; object = config; };
	in
		template;
	
	getDefinition =
	{
		config,
		name,
		template,
	}:
	let
		namespace = namespaces.definitions ++ [ template prefixes.definitions name ];

		definition = utils.options.getFromKeys { keys = namespace; object = config; };
	in
		definition;

	getAllDefinitions =
	{
		config,
		template,
	}:
	let
		namespace = namespaces.definitions ++ [ template prefixes.definitions ];

		definitions = utils.options.getFromKeys { keys = namespace; object = config; };
	in
		definitions;

	getAllExtenders =
	{
		config,
		name,
	}:
	let

		template = getTemplate { inherit config name; };

		getExtenders = template: 
		let

			extenders = template.meta.extends;

			iterate = (builtins.map (name: getTemplate { inherit config name; }) extenders) ++ (builtins.map 
			(name:
			let
				template = getTemplate { inherit config name; };
			in
				if (template.meta.extends != []) 
				then 
					(getExtenders template) 
				else 
					[]
			) extenders);

		in
			lib.lists.unique (lib.lists.flatten iterate);

	in
		getExtenders template;
in
{

	inherit 
		prefixes 
		namespaces
		getTemplate
		getAllExtenders
		getDefinition
		getAllDefinitions
	;

}
