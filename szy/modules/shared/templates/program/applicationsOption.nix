{ szy, lib, config, ... }:
{

	options."${szy}".applications = 
	let

		getDefinitions = template: 
		builtins.map 
		(
			meta: 
			szy.objects.helper.getDefinition 
			{ 
				inherit config; 
				inherit (meta) name template; 
			}
		) 
		config."${szy}".objects."${template}".meta.full.definitions;

		getTemplates = definitions:
		let
			names = lib.lists.unique (builtins.map (definition: definition.meta.template) definitions);
		in
			builtins.map (name: szy.objects.helper.getTemplate { inherit config name; }) names;
	
		defaultApplications = getDefinitions "defaultApplication";
		defaultTemplates = getTemplates defaultApplications;
		applications = getDefinitions "application";
		templates = getTemplates applications;

		defaultModule.options =
		{

			default = lib.options.mkOption
			{

				type = lib.types.attrs;
				default =
				builtins.listToAttrs
				(
					builtins.map
					(
						template:
						{
							name = template.meta.name;
							value =
							let
								defaults = template.data.default;
							in
							lib.attrsets.mapAttrs
							(
								name: value:
									if (value == null) then null else value.value
							)
							defaults;
						}
					)
					defaultTemplates
				);

			};

		};

		modules =
		builtins.map
		(
			template:
			{

				options."${template.meta.name}" = lib.options.mkOption
				{

					type = lib.types.attrs;
					default =
					let
						definitions = template.definitions;
					in
						definitions;
				};

			}
		)
		templates;

	in
	lib.options.mkOption
	{

		type = lib.types.submoduleWith { modules = [ defaultModule ] ++ modules; };

		readOnly = true;

	};

}
