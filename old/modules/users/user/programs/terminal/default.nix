{ szy, config, ... }:
szy.programs.mkProgram
{

	inherit config;
	name = "terminal";

	additionalValues = [	
		"runProgram"
	];

}
