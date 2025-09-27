{ szy, lib, config, ... }:
let

	resolvedProfilePrefix = 
	let
		profilePrefix = config."${szy}".desktops.profilePrefix;
		branchList = builtins.map (name: "branches") profilePrefix;
	in
		lib.lists.flatten (lib.lists.zipListsWith (a: b: [ a b ]) profilePrefix branchList);

	availableDesktops = config."${szy}".desktops.available;

in
{

	options."${szy}".desktops = {

		profilePrefix = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			default = [ "desktop" ];
		};

		available = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			readOnly = true;
			default = builtins.attrNames config."${szy}".desktops.desktops;
		};

		enabled = lib.mkOption {
			type = lib.types.nullOr (lib.types.listOf (lib.types.enum availableDesktops));
			default = null;
		};

		default = lib.mkOption {
			type = lib.types.nullOr (lib.types.enum availableDesktops);
			default = null;
		};

		desktopData = lib.mkOption {
			type = lib.types.nullOr lib.types.attrs;
			default = null;
		};

	};	

	config."${szy}".profiles.base.branches = (lib.attrsets.setAttrByPath (lib.lists.init resolvedProfilePrefix) {

		configuration = {
			
			environment.sessionVariables.NIXOS_OZONE_WL = "1";

			imports = [
				./power.nix
			];

		};

		branches = (lib.listToAttrs (builtins.map (desktop:
		let
			desktopValues = config."${szy}".desktops.desktops."${desktop}";
			assertDesktop = name: assert (builtins.elem name availableDesktops); name;
			desktopData = rec {
				default = desktop;
				enabled = desktopValues.enabled;
				isDefault = name: (assertDesktop name) == default;
				isEnabled = name: builtins.elem (assertDesktop name) availableDesktops;
				isAnyDefault = names: builtins.any (value: value == true) (builtins.map (desktop: isDefault desktop) names);
				isAnyEnabled = names: builtins.any (value: value == true) (builtins.map (desktop: isEnabled desktop) names);
			};
		in
		{
			name = desktop;
			value = {
				configuration = { 
				
					"${szy}".desktops = {
						default = lib.mkForce desktop;
						enabled = lib.mkForce desktopValues.enabled;
						desktopData = lib.mkForce desktopData;
					};

					imports = (lib.lists.flatten (builtins.map (currentDesktop: (config."${szy}".desktops.desktops."${currentDesktop}".imports)) desktopValues.enabled)) ++ [ ({ _module.args.desktop = desktopData; }) ] ++ (builtins.map (currentDesktop: (config."${szy}".desktops.desktops."${currentDesktop}".configuration)) desktopValues.enabled);

				};
			};
		}) availableDesktops));

	});

}
