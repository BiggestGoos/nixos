{ lib, ... }:
{

	inputs =
	{	
		flake.url = "github:BiggestGoos/nixos";
	};

	imports =
	[
		(lib.trivial.importJSON ./flake.inputs)
	];

	outputs = inputs:
	let
		data = import ./data.nix inputs;
		overrideData = 
		if (builtins.pathExists ./overrideData.nix)
		then import ./overrideData.nix inputs
		else null;
	in
	(
		inputs.flake.outputs
		(import ./hostname.nix)
		inputs
		(
			if (overrideData == null)
			then data
			else overrideData
		)
	);

}
