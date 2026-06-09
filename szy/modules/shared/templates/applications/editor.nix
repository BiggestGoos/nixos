{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "editor";

	extends = [ "defaultApplication" ];

	configuration =
	{ enabled, final }:
	let

		default = final.data.default.any.value;
		defaultOpen = (default.data.commands.exec or default.data.commands.open).relative;

	in
	{
		"${szy}".variables =
		{
			EDITOR = lib.mkDefault defaultOpen;
			VISUAL = lib.mkDefault defaultOpen;
		};
	};

}
