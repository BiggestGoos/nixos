{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;

	name = "floorp";
	template = "browser";

	arguments =
	{ final, object }:
	{

		application = {
			type = "gui";
		};

		package = pkgs.floorp-bin;

		commands.search = "${final.data.commands.exec} --search";

	};

}
