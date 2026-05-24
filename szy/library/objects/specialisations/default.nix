{ identifier, lib, utils, importLib, helper, ... }@gInputs:
let

	composable = import ./composable.nix gInputs;

in
{

	inherit (composable) composable;
	
}
