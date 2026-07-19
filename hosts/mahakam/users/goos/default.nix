{ szy, lib, config, pkgs, ... }:
(szy config).users.user.create "goos" true
{

	enable = true;

	arguments =
	{

		paths = 
		[
			./home
		];
	
	};

}
