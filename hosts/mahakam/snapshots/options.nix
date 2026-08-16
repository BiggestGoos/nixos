{ lib, ... }:
{

	options.snapshots.baseDirectory = lib.options.mkOption
	{
		type = lib.types.str;
		default = "/snapshots";
	};

}
