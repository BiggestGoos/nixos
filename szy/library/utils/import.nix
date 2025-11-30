{ root, lib }:
rec {

	internal.shared = rec {

		path = root + "/szy/internal/shared";
		from = file: path + "/${file}";

	};

	modules = rec {

		path = root + "/szy/modules";
		from = file: path + "/${file}";

		users.user = rec {

			path = root + "/szy/modules/users/user";

			desktops = rec {
				
				path = root + "/szy/modules/users/user/desktops";

			};

		};

	};

}
