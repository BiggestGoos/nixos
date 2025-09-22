{ pkgs, lib, config, szy, ... }:
{

	imports = [
		(szy.utils.fromRoot "szy/desktops")
	];

	config = {

		profiles.base.branches.desktop.configuration = {

			environment.sessionVariables.NIXOS_OZONE_WL = "0";

			imports = [
				./power.nix
			];

		};

		profiles.base.branches.desktop.branches = 
		let
		
			mkDesktops = desktops: builtins.listToAttrs (builtins.map (desktop: 
			let
				default = desktop.default;
				enabled = [ default ] ++ (desktop.enabled or [  ]);

				value.configuration = {
					imports = (builtins.map (e: ./${e}) enabled);

					desktops = { inherit default enabled; };
				};
			in
				{
					name = default;
					value = value;
				}
			) desktops);

		in
			mkDesktops [
			{
				default = "hyprland";
#				enabled = [ "gnome" ];
			}
			{
				default = "gnome";
#				enabled = [ "hyprland" ];
			}
			{
				default = "plasma";
#				enabled = [ "hyprland" ];
			}
			];

	};

}
