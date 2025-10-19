additionalConfiguration:
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
			default = builtins.attrNames (builtins.removeAttrs (lib.attrsets.mapAttrs' (name: value: (if (value.isEnabled) then { inherit name value; } else { name = ""; value = {}; })) config."${szy}".desktops.desktops) [ "" ]);
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

		configuration = szy.utils.mergeAll [ additionalConfiguration ({

			imports = [
				./options/variants
				./options/power
				./options/displays
				./options/devices
				./options/variables
			];

		}) ];

		branches = (lib.listToAttrs (builtins.map (desktop:
		let
			compareLists = l1: l2: (if ((builtins.length l1) > (builtins.length l2)) then false else (lib.lists.all (x: x == true) (lib.lists.imap0 (i: e1: (e1 == (builtins.elemAt l2 i))) l1)));
			compareListsStrict = l1: l2: l1 == l2;

			availableDesktopsNames = builtins.map (desktopName: 
				config."${szy}".desktops.desktops."${desktopName}".names
			) availableDesktops;

			enabledDesktopsNames = builtins.map (desktopName: 
				config."${szy}".desktops.desktops."${desktopName}".names
			) desktopValues.enabled;

			desktopValues = config."${szy}".desktops.desktops."${desktop}";
			assertDesktop = names: assert (lib.lists.any (x: x == true) (builtins.map (desktopNames: compareLists names desktopNames) availableDesktopsNames)); names;
			desktopData = rec {
				default = desktopValues.names;
				enabled = desktopValues.enabled;
				isDefault = names: compareLists (assertDesktop names) default;
				isEnabled = names: (lib.lists.any (x: x == true) (builtins.map (desktopNames: compareLists (assertDesktop names) desktopNames) enabledDesktopsNames));
				isDefaultStrict = names: compareListsStrict (assertDesktop names) default;
				isEnabledStrict = names: (lib.lists.any (x: x == true) (builtins.map (desktopNames: compareListsStrict (assertDesktop names) desktopNames) enabledDesktopsNames));
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
