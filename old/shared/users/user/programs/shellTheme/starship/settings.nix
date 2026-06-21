{ lib, ... }:
let

	colors = {

		"1" = {
			foreground = "008e00";
			background = "000000";
		};

		"2" = {
			foreground = "00ee00";
			background = "000000";
		};

		"3" = {
			foreground = "008e00";
			background = "000000";
		};

	};

in
{

	"$schema" = "https://starship.rs/config-schema.json";

	format = 
	let

		shapes = {
			circle = {
				left = "";
				right = "";
			};
			triangle = {
				left = "";
				right = "";
			};
			slopeUp = {
				left = "";
				right = "";
			};
			slopeDown = {
				left = "";
				right = "";
			};
			arrow = {
				right = "➤";
			};
		};

		spacer = color: if (color != null) then "[ ](bg:#${color})" else " ";

	in
		lib.concatStrings [
			(spacer null)
			"[${shapes.circle.left}](fg:#${colors."1".foreground})"
			(spacer colors."1".foreground)
			"[$username@$hostname](bold fg:#${colors."1".background} bg:#${colors."1".foreground})"
			(spacer colors."1".foreground)
			"[${shapes.slopeDown.right}](bg:#${colors."2".foreground} fg:#${colors."1".foreground})"
			(spacer colors."2".foreground)
			"[$directory](bg:#${colors."2".foreground} fg:#${colors."2".background})"
			(spacer colors."2".foreground)
			"[${shapes.circle.right}](fg:#${colors."2".foreground})"
			(spacer null)
			"("
				"[${shapes.triangle.left}](fg:#${colors."3".foreground})"
				(spacer colors."3".foreground)
				"[$git_branch$git_status](fg:#${colors."3".background} bg:#${colors."3".foreground})"
				(spacer colors."3".foreground)
				"[${shapes.triangle.right}](fg:#${colors."3".foreground})"
				(spacer null)
			")"
			"[${shapes.arrow.right}](fg:#${colors."2".foreground})"
			(spacer null)
		];

	username = {

		show_always = true;
		#style_user = "bg:#9A348E";
		#style_root = "bg:#9A348E";
		format = "$user";
		disabled = false;

	};

	hostname = {

		ssh_only = false;
		format = "$hostname";

	};

	directory = {

		#style = "bg:#DA627D";
		format = "$path";
		truncation_length = 3;
		truncation_symbol = "…/";

	};

	git_branch = {
		style = "bg:#FCA17D";
		format = "$symbol$branch(:$remote_branch)";
	};

	git_status = {
		style = "bg:#FCA17D";
		format = "(\\[$all_status$ahead_behind\\])";
	};

}
