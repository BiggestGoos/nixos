{ lib, szy, config, ... }:
szy.programs.mkProgram
{

	inherit config;
	name = "passwordManager";

}
