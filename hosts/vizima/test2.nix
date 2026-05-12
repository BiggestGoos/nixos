{ szy, config, lib, ... }:
szy.objects.define
{
	
	callerData = {
		inherit config;
	};

	template = "program";

	name = "firefox";

	arguments = 
	{ final }:
	{

		test = "hello " + final.data.command;

	};

}
