{ lib, ... }:
{

	inputs =
	{	
		flake.url = 
		let
			overrideUrl = 
			if (builtins.pathExists ./overrideUrl.nix)
			then import ./overrideUrl.nix
			else null;
		in
		(
			if (overrideUrl == null)
			then "github:BiggestGoos/nixos"
			else overrideUrl
		);
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
