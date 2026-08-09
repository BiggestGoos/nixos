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
	(
		inputs.flake.outputs
		"kovir"
		inputs
		{
			modules =
			[
				inputs.outerWall.module
			];
		}
	);

}
