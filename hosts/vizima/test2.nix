{ szy, config, lib, ... }:
szy.objects.define
{
	
	callerData = {
		inherit config;
	};

	template = "program-gui";

	name = "firefox";

	arguments = 
	{ final }:
	{

		

	};
	
	configuration =
	enabled:
	{ final }:
	{

		programs."${final.data.command}".enable = enabled.is;

	};

}
