{ identifier, lib, utils, ... }:
let

	prefixes = {

		objects = "objects";
		templates = "templates";
		definitions = "definitions";

	};

	namespaces = {

		templates = with prefixes; [ identifier objects templates ];
		definitions = with prefixes; [ identifier objects definitions ];

	};

	getTemplate =
	{
		config,
		name,
	}:
	let
		
		baseNamespace = namespaces.templates ++ lib.lists.toList name;

		base = utils.options.getFromKeys { keys = baseNamespace; object = config; };

		namespace = base.namespace;

		template = if (namespace == baseNamespace) then base else
			utils.options.getFromKeys { keys = namespace; object = config; }

	in
		template;
		
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

			iterate = extenders ++ (builtins.map 
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
	;



}
