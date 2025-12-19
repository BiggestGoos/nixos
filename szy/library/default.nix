{ inputs }:
let
	flake = inputs.self;
	root = "${flake}";

	inherit (inputs.nixpkgs) lib;

	self = 
	rec {

		inherit inputs;

		flake = import ./flake { inherit self lib; };

		__functor = 
		self:
		{ hostname, rawRoot }:
		let

			szy = 
			let

				inherit (self.inputs.self.nixosConfigurations."${hostname}") config _module;

				importFunc = import ./import { inherit root lib; };

				utils = import ./utils { inherit root rawRoot hostname lib; };
				desktops = import ./desktops { inherit config lib options utils; };
				profiles = import ./profiles;
				programs = import ./programs { inherit config lib options utils; };
				users = import ./users { inherit config lib options szy; };
				variants = import ./variants { inherit options lib utils; };
				themes = import ./themes { inherit options lib utils variants; };

				options = "szy-" + utils.hostname;

			in
			{

				inherit config;

				inherit 
					utils
					desktops
					profiles
					programs
					users
					variants
					themes;
				import = importFunc;

				__toString = self: options;

			};

		in
			szy;

	};

in
	self
