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
	let
		extraInputs = 
		if (builtins.pathExists ./extraInputs.nix)
		then import ./extraInputs.nix
		else {};
	in
	[
		(lib.trivial.importJSON ./flake.inputs)
		extraInputs
	];

	outputs = inputs:
	let
		inherit (inputs.nixpkgs) lib;

		data' = import ./data.nix inputs;

		extraModules =
		if (builtins.pathExists ./extraModules.nix)
		then import ./extraModules.nix inputs
		else [];

		extraMetaData = 
		if (builtins.pathExists ./extraMetaData.nix)
		then import ./extraMetaData.nix inputs
		else {};

		data = data' //
		{
			modules = (data'.modules or []) ++ extraModules;
			metaData = lib.attrsets.recursiveUpdate data'.metaData extraMetaData;
		};
	in
	(
		inputs.flake.outputs
		(import ./hostname.nix)
		inputs
		data
	);

}
