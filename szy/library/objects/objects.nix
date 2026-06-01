{ identifier, lib, utils, meta, importLib, ... }@gInputs:
let

	helperInputs = gInputs // { inherit helper; };

	inputs = helperInputs // { inherit qualifiers; };

	declare = import ./declare.nix inputs;
	define = import ./define.nix inputs;
	helper = import ./helper.nix gInputs;
	qualifiers = import ./qualifiers helperInputs;

in
{

	inherit (declare) declare;
	inherit (define) define;
	inherit helper qualifiers;

}
