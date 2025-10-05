theme:
{ szy, inputs, hostname, config, lib, pkgs, ... }:
{

	imports = [
		./optimizations.nix
		./styling.nix
		{
			_module.args = {
				inherit theme;
			};
		}
	];

	programs.floorp = lib.mkIf theme.enabled {

		languagePacks = [
			"en-US"
			"sv-SE"
		];

		profiles."${config.home.username}" = {

			settings = {

				"identity.fxaccounts.account.device.name" = szy.utils.hostname;
				"identity.fxaccounts.enabled" = true;

				"middlemouse.paste" = false;
				"general.autoScroll" = true;
				"apz.overscroll.enabled" = false;
				# Scrollspeed with trackpad
				"mousewheel.default.delta_multiplier_y" = 250;

				"toolkit.tabbox.switchByScrolling" = true;

				"media.autoplay.blocking_policy" = 0;

				"privacy.resistFingerprinting" = true;

				"privacy.clearOnShutdown.cookies" = false;
				"privacy.clearOnShutdown.history" = false;
				"privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
				"privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
				"privacy.clearOnShutdown_v2.history" = false;

				"browser.translations.automaticallyPopup" = false;
				"browser.translations.neverTranslateLanguages" = "sv"; # E.g. "sv,fi,..."

				"floorp.workspaces.enabled" = false;

			};

		};

		# Set custom keybinds: https://superuser.com/a/1747680

	};

}
