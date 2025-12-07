enabled:
{ lib, ... }:
lib.mkIf (enabled)
{

	boot.kernel.sysctl."vm.max_map_count" = 2147483642;

}
