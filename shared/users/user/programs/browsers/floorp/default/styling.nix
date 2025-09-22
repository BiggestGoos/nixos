{ variant, lib, config, ... }:
lib.mkIf variant.enabled
{

	# https://www.reddit.com/r/firefox/comments/17hlkhp/what_are_your_must_have_changes_in_aboutconfig/

	programs.floorp.profiles."${config.home.username}" = {

		# Change into .nix files, will allow e.g. to hide close button etc based on an option instead of always.
		userChrome = builtins.readFile ./css/userChrome.css;
		userContent = builtins.readFile ./css/userContent.css;

		settings = {

			# Copy and paste from about:config
			"browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":["sidebar-button","print-button","sync-button","developer-button"],"unified-extensions-area":["ublock0_raymondhill_net-browser-action","_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action","_88ebde3a-4581-4c6b-8019-2a05a9e3e938_-browser-action","canvasblocker_kkapsner_de-browser-action","addon_darkreader_org-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","undo-closed-tab","home-button","personal-bookmarks","urlbar-container","history-panelmenu","vertical-spacer","fxa-toolbar-menu-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","unified-extensions-button","preferences-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["alltabs-button","tabbrowser-tabs","new-tab-button","zoom-controls","downloads-button","firefox-view-button"],"vertical-tabs":[],"PersonalToolbar":[],"nora-statusbar":["screenshot-button","fullscreen-button","status-text"]},"seen":["developer-button","ublock0_raymondhill_net-browser-action","screenshot-button","_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action","_88ebde3a-4581-4c6b-8019-2a05a9e3e938_-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","canvasblocker_kkapsner_de-browser-action","addon_darkreader_org-browser-action","undo-closed-tab","workspaces-toolbar-button"],"dirtyAreaCache":["nav-bar","vertical-tabs","toolbar-menubar","TabsToolbar","PersonalToolbar","unified-extensions-area","widget-overflow-fixed-list","nora-statusbar"],"currentVersion":23,"newElementCount":30}'';	

			# Allow CSS
			"toolkit.legacyUserProfileCustomizations.stylesheets" = true;

			"browser.uidensity" = 1;

			"browser.tabs.tabClipWidth" = 999;

			"widget.non-native-theme.scrollbar.style" = 2;

			"browser.toolbars.bookmarks.visibility" = "never";
			"browser.tabs.inTitlebar" = 0;

		};

	};

}
