{ szy, lib, config, pkgs, ... }:
(szy config).users.user.create "goos" true
{

	arguments =
	{

		paths = 
		[
			./home
		];
	
	};

}
