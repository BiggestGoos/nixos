{ lib, ... }:
{

	options.outerWall =
	{

		enable = lib.options.mkOption
		{
			type = lib.types.bool;
			default = false;
		};

		username = lib.options.mkOption
		{
			type = lib.types.str;
			default = "outerWall";
		};

		lock =
		{
			lockfile = lib.options.mkOption
			{
				type = lib.types.str;
				default = "/run/outerWallLock";
			};

			tty = lib.options.mkOption
			{
				type = lib.types.int;
				default = 6;
			};
		};

	};

}
