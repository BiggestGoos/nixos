{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "package";
	enable = true;

	parameters =
	{ final, object }:
	{

		package = lib.options.mkOption
		{
			type = lib.types.package;
			default = 
			let
				name = final.meta.name;
				packageExists = builtins.hasAttr name pkgs;
			in
				if packageExists then pkgs."${name}" else "No package with name { ${name} }";
		};

	};

}
