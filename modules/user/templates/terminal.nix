{ szy, lib, config, pkgs, ... }:
(szy config).objects.make.template
{
	
	name = "terminal";
	namespace = [ "programs" ];

	inherits = [ "default" "application" ];

	constant.type = lib.mkForce "gui";

	variable =
	{ variable, meta, ... }:
	{

		program.actions =
		{
			runCommand = {}; #.required = lib.mkForce true;
			/*remainOpen =
			{
				required = lib.mkForce true;
				generateCommand = false;
			};
			setDirectory =
			{
				required = lib.mkForce true;
				generateCommand = false;
			};
			setAppID =
			{
				required = lib.mkForce true;
				generateCommand = false;
			};
			setTitle =
			{
				required = lib.mkForce true;
				generateCommand = false;
			};*/
		};

		/*desktopEntry._default =
		{
			overrides =
			{
				extraConfig =
				let
					inherit (final.data.program) arguments;
					values =
					{
						"X-TerminalArgExec" = arguments.runCommand;
						"X-TerminalArgHold" = arguments.remainOpen;
						"X-TerminalArgDir" = arguments.setDirectory;
						"X-TerminalArgAppId" = arguments.setAppID;
						"X-TerminalArgTitle" = arguments.setTitle;
					};
				in
				lib.attrsets.mapAttrs
				(
						name: value:
							lib.strings.concatStringsSep " " value.args
				)
				values;
			};		
		};*/
		
		/*desktopEntry.runCommand =
		{

			required = lib.mkForce true;

			overrides =
			let
				name = variable.entry.default.final.name or (lib.lists.last meta.identifier);
			in
			{
				categories = [ "TerminalEmulator" ];
				exec = lib.mkDefault variable.commands.runCommand.relative;
				name = lib.mkDefault "${name}/runCommand";
				noDisplay = true;
				desktopName = "${name}-runCommand";
			};

		};*/

	};

	output.config =
	{ constant, anyObjectEnabled, ... }:
	let
		default = constant.default.any;
		defaultOpen = default.variable.commands.default.relative;
		defaultRunCommand = default.variable.commands.runCommand.relative;

		scriptName = "${szy}+defaultTerminal";
		script = pkgs.writeShellScriptBin scriptName
''
first=$1

if [[ "$first" == */* ]]; then
    # Explicit path
    if [[ -f "$first" && -x "$first" ]]; then
        exec ${defaultRunCommand} "$@"
    fi
else
    # Command in PATH
    if type -P -- "$first" >/dev/null 2>&1; then
        exec ${defaultRunCommand} "$@"
    fi
fi

exec ${defaultOpen} "$@"
'';
		
	in
	anyObjectEnabled
	{

		/*xdg.terminal-exec =
		{
			enable = true;
			settings =
			{
				default =
				[
					default.variable.entry.runCommand.final.id
				];
			};
		};*/

		"${szy}" =
		{
			variables.TERMINAL =
			{
				value = scriptName;
				override = "force";
			};
			packages = [ script ];
		};

	};

}
