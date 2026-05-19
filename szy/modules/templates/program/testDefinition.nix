{ szy, lib, config, ... }:
szy.objects.define
{

	inherit config;

	name = "firefox";

	template = "program";

}
