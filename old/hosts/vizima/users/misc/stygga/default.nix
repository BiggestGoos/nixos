{ pkgs, ... }:
{

	users = {

		groups.stygga = {};

		users = {

			goos.extraGroups = [ "stygga" ];

		};

	};

	boot.enableContainers = true;

}
