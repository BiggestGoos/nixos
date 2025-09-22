variant:
{ szy, config, lib, ... }:
lib.mkIf variant.enabled
{

	programs.librewolf = {

		languagePacks = [
			"en-US"
			"sv-SE"
		];

		profiles."${config.home.username}" = {

			userChrome = builtins.readFile ./css/userChrome.css;
			userContent = builtins.readFile ./css/userContent.css;

			settings = {
				
				# Copy and paste from about:config
				"browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":["fullscreen-button","sidebar-button","print-button","sync-button","developer-button"],"unified-extensions-area":["ublock0_raymondhill_net-browser-action","_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action","_88ebde3a-4581-4c6b-8019-2a05a9e3e938_-browser-action","canvasblocker_kkapsner_de-browser-action","addon_darkreader_org-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","personal-bookmarks","urlbar-container","history-panelmenu","vertical-spacer","save-to-pocket-button","fxa-toolbar-menu-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","unified-extensions-button","preferences-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["alltabs-button","tabbrowser-tabs","new-tab-button","zoom-controls","downloads-button","firefox-view-button"],"vertical-tabs":[],"PersonalToolbar":[]},"seen":["developer-button","ublock0_raymondhill_net-browser-action","screenshot-button","_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action","_88ebde3a-4581-4c6b-8019-2a05a9e3e938_-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","canvasblocker_kkapsner_de-browser-action","addon_darkreader_org-browser-action"],"dirtyAreaCache":["nav-bar","vertical-tabs","toolbar-menubar","TabsToolbar","PersonalToolbar","unified-extensions-area","widget-overflow-fixed-list"],"currentVersion":22,"newElementCount":28}'';

			};

		};

		# Set custom keybinds: https://superuser.com/a/1747680

		settings = {
			"webgl.disabled" = false;

			"identity.fxaccounts.enabled" = true;

			"middlemouse.paste" = false;
			"general.autoScroll" = true;
			"apz.overscroll.enabled" = false;
			# Scrollspeed with trackpad
			"mousewheel.default.delta_multiplier_y" = 250;

			"media.autoplay.blocking_policy" = 0;

			"privacy.resistFingerprinting" = true;

			# Allow CSS
			"toolkit.legacyUserProfileCustomizations.stylesheets" = true;

			"privacy.clearOnShutdown.cookies" = false;
			"privacy.clearOnShutdown.history" = false;
			"privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
			"privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
			"privacy.clearOnShutdown_v2.history" = false;

			"browser.translations.automaticallyPopup" = false;
			"browser.translations.neverTranslateLanguages" = "sv"; # E.g. "sv,fi,..."
		};

	};

}
