{ szy, lib, config, ... }:
{

	options."${szy}".secrets.public = lib.options.mkOption
	{
		type = lib.types.anything;
	};

}
