{ additionalTools ? [] }@inputs:
{ szy, lib, config, pkgs, ... }@inputs:
let
	package = pkgs.hello;
	
	defaultTools = with pkgs; [
		hello
		tree
		wget
	];

	homeManaged = builtins.hasAttr "osConfig" inputs;

in
szy.programs.mkInstance
{

	inherit config;
	program = "terminalTools";

	values = 
	{
		inherit package;
	};

	configuration =
	{ enabled, optionKeys, ... }:
	let

		allTools = defaultTools ++ additionalTools;

		options =
		(lib.attrsets.setAttrByPath ([ "${szy}" ] ++ optionKeys ++ [ "options" ]) 
		{

			tools = builtins.listToAttrs (builtins.map (tool: 
				{
					name = tool.pname;
					value = lib.mkOption {
						type = lib.types.bool;
						default = true;
					};
				}
			) allTools);

			test = lib.mkOption {
				type = lib.types.listOf lib.types.package;
				default = resolvedTools;
			};

		});

		resolvedTools = builtins.filter (tool: (lib.attrsets.attrByPath ([ "${szy}" ] ++ optionKeys ++ [ "options" ]) { tools = {}; } config).tools."${tool.pname}" or false) allTools;

	in
	(if (!homeManaged) then ({
		config.environment.systemPackages = lib.mkIf (enabled) resolvedTools;
		inherit options;
	}) else ({
		config.home.packages = lib.mkIf (enabled) resolvedTools;
		inherit options;
	}));

}

