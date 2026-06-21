root:
let
	compress = "compress-force=zstd:15";
in
{

	"@games" = {
		mountOptions = [ "defaults" compress ];
		mountpoint = "${root}/Games";
	};

}
