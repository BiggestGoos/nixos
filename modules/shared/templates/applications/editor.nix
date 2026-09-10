{ szy, lib, config, pkgs, ... }:
(szy config).objects.make.template
{
	
	name = "editor";
	namespace = [ "programs" ];

	inherits = [ "default" "application" ];

	output.config =
	{ constant, ... }:
	let

		default = constant.default.any;
		defaultOpen = default.variable.commands.default.relative;

		scriptName = "${szy}+defaultEditor";
		script = pkgs.writeShellScriptBin scriptName
''
exec ${defaultOpen} "$@"
'';

	in
	{
		"${szy}" =
		{
			variables =
			{
				EDITOR = lib.mkDefault
				{
					value = scriptName;
					override = "force";
				};
				VISUAL = lib.mkDefault
				{
					value = scriptName;
					override = "force";
				};
			};
			packages = [ script ];
		};
	};

}
