{ root, lib }:
let

	propogate = object: imports: builtins.map (module: if (builtins.isFunction (import module)) then ((import module) ({ value = object; import = propogate object.value; __functor = self: propogate object.value; })) else (import module)) imports;

	toggleableModule = enabled: module: lib.mkIf (enabled) module;

	toggleable = enabled: imports: builtins.map (module: (import module) { value = enabled; import = toggleable enabled; __functor = self: module: toggleableModule enabled module; }) imports;

in
rec {

	internal.shared = rec {

		path = root + "/szy/modules/internal/shared";
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

	inherit propogate;
	
	inherit toggleable;

}
