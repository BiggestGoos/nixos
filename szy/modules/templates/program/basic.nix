{ szy, lib, config, ... }:
szy.objects.declare
{

	callerData = { inherit config; };

	name = "program";

	extends = [ "defaultDefinition" ];

}
