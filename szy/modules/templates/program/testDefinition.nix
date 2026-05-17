{ szy, lib, config, ... }:
szy.objects.define
{

	callerData = { inherit config; };

	name = "firefox";

	template = "program";



}
