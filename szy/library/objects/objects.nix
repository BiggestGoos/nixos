{ identifier, lib, utils, meta, importLib, ... }@gInputs:
let

	helperInputs = lib.trivial.mergeAttrs gInputs { inherit helper; };

	declare = import ./declare.nix helperInputs;
	define = import ./define.nix helperInputs;
	helper = import ./helper.nix gInputs;
	specialisations = import ./specialisations helperInputs;

in
{

	inherit (declare) declare;
	inherit (define) define;
	inherit helper;
	inherit (specialisations) composable;

}
