{ pkgs, lib, ... }:
{
	
	users.users.goos = import ./goos { inherit pkgs; };

}
