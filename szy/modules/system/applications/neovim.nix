{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "editor";

	name = "neovim";

	arguments = 
	{ final, object }:
	{

		application.type = "cli";

	};

	configuration = 
	enabled:
	{ final, object }:
	enabled
	{

		programs.neovim = {

			enable = true;

			defaultEditor = object.data.default.cli == { inherit (final.meta) name template; };

		};	

	};

}

