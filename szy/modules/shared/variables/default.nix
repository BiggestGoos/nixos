{ szy, lib, config, systemConfig, ... }:
let

	inherit (config."${szy}") variables;

	setDefault = variables:
	lib.attrsets.mapAttrs
	(
		name: value:
		lib.mkDefault value
	)
	variables;

in
{

	options."${szy}".variables = lib.options.mkOption
	{
		type = lib.types.attrsOf lib.types.str;
	};

	config =
	if (systemConfig)
	then
	{

		environment.sessionVariables = setDefault variables;

	}
	else
	{

		home.sessionVariables = setDefault variables;
		systemd.user.sessionVariables = setDefault variables;

	};

}
