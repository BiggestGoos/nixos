{ lib, config, pkgs, ... }:
{

	options.profiles = {

		base.branches = lib.mkOption {

			type = 
			let
				template = {

					options.branches = lib.mkOption {
						type = lib.types.attrsOf (lib.types.submoduleWith { modules = [ template ]; });	
						default = { };
					};

					options.configuration = lib.mkOption {
						type = lib.types.attrs;
						default = { };
					};

					options.resolveTo = lib.mkOption {
						type = lib.types.bool;
						default = false;
					};

				};
			in
				lib.types.attrsOf (lib.types.submoduleWith { modules = [ template ]; });

		};

		resolved = lib.mkOption {

			type = lib.types.listOf (lib.types.listOf lib.types.attrs);
			readOnly = true;

			default = 
			let
				flattenTree = import ./flattenTree.nix;
			in
				(flattenTree config.profiles.base);

		};

		available = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			readOnly = true;

			default = 
			let
				result = (builtins.map (profile: (builtins.concatStringsSep "-" (builtins.map (branch: branch.name) profile))) config.profiles.resolved);
			in
				result;

		};

		default = lib.mkOption {
			type = lib.types.enum (config.profiles.available);
			default = (builtins.elemAt (config.profiles.available) 0);
		};

		test = lib.mkOption {
			
			type = lib.types.attrs;

		};

	};

	config = {

		specialisation = (builtins.listToAttrs (builtins.map (
		profile: 
		let

			name = (builtins.concatStringsSep "-" (builtins.map (branch: branch.name) profile));
			value.configuration = 
			{ 
				environment.etc."specialisation".text = name;

				profiles.default = name;
				
				imports = (builtins.map (branch: branch.configuration) profile);
			};

		in
			{
				inherit name value;
			}
		) config.profiles.resolved));

		#Make agnostic to bootloader, or at least throw error if not systemd-boot for the moment.
		boot.loader.systemd-boot.extraInstallCommands = ''
			${pkgs.gnused}/bin/sed -i -E "s/default nixos-generation-([0-9]+).*\.conf/default nixos-generation-\1-specialisation-${config.profiles.default}.conf/" /boot/loader/loader.conf
		'';

	};

	#config = 
	#{

		

		/*profiles.resolved = 
		let
			base = config.profiles.base;

			get_count = 
			{ current }:
			if !(builtins.hasAttr "branches" current) then
				1
			else
			let
				branches = current.branches;
				names = builtins.attrNames branches;
				count = builtins.length names;

				inner_counts = builtins.genList (i:
				let
					name = builtins.elemAt names i;
					elem = builtins.getAttr name branches;

					result =
					(if !(builtins.hasAttr "branches" elem)
					then
						1
					else
					let
						inner_result = get_count { current = elem; };
					in
						inner_result);
				in
					result
				) count;

				result_count = 
				let
					combine_list = builtins.genList (i: 
					if (i == 0)
					then
						builtins.elemAt inner_counts i
					else
						(builtins.elemAt combine_list (i - 1)) + (builtins.elemAt inner_counts i)
					) count;
					result = lib.lists.last combine_list;
				in
					result;
			in
				result_count;

			flatten =
			{ current }:
			let

				branches = current.branches;
				branch_names = builtins.attrNames branches;
				branch_count = builtins.length branch_names;

				deep_branch_count = get_count { current = current; };

				inner_lists = builtins.genList (i:
				let
					name = builtins.elemAt branch_names i;
					elem = builtins.getAttr name branches;
					value = elem.configuration;

					result = 
					(if !(builtins.hasAttr "branches" elem) then
						[ { inherit name; imports = value; } ]
					else let
						inner_result = (flatten { current = elem; });
					in
						inner_result);

				in
					result
				) branch_count;
				
				num_list = builtins.genList (i:
				if i == 0 then
				let
					name = builtins.elemAt branch_names i;
					elem = builtins.getAttr name branches;
				in
					{ 
						count = get_count { current = elem; };
						index = 0;
						current = 0;
					}
				else
				(let
					last = builtins.elemAt num_list (i - 1);
				in
				if (last.current < (last.count - 1)) then
					{
						count = last.count;
						index = last.index;
						current = last.current + 1;
					}
				else
				let
					last = builtins.elemAt num_list (i - 1);
					name = builtins.elemAt branch_names (last.index + 1);
					elem = builtins.getAttr name branches;
				in
					{
						count = get_count { current = elem; };
						index = last.index + 1;
						current = 0;
					}
				)) deep_branch_count;

				current_lists = builtins.genList (u:
				let
					num = builtins.elemAt num_list u;
					i = num.index;
					ii = num.current;
					name = builtins.elemAt branch_names i;
					elem = builtins.getAttr name branches;
					value = elem.configuration;
					list = builtins.elemAt inner_lists i;
				in
					if !(builtins.hasAttr "branches" elem) then
						[ { inherit name; imports = value; } ]
					else
						[ { inherit name; imports = value; } ]  ++ (builtins.elemAt list ii)
				) deep_branch_count;

			in
				current_lists;

			flat = flatten { current = base; };

			#resolved = { inherit flat; };

			#configs = builtins.map (list: builtins.concatLists (builtins.map (list: list.configuration) list)) flat;
			names = builtins.map (list: builtins.concatStringsSep "-" (builtins.map (list: list.name) list)) flat;
			count = builtins.length names;

			resolved = { inherit names count; };

			#resolved = (builtins.listToAttrs (builtins.genList (i: { name = (builtins.elemAt names i); value = {
			#	configuration = {
			#		config = {
			#			environment.etc."specialisation".text = (builtins.elemAt names i);
			#			desktops.default = (builtins.elemAt names i);
			#		};
			#		imports = (builtins.elemAt imports_list i); 
			#	};
			#}; }) count));

			#test = get_count { current = base.branches.gfx.branches.hyprland; };
			#resolved = { inherit test; };
		in
			resolved;

		#specialisation = (builtins.listToAttrs );

		#specialisation = config.profiles.resolved;*/

	#};

}
