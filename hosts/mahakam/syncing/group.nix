{ szy, config, ... }:
{

	"${szy}".objects.user.data.types.normal.groups =
	[
		config.sync.user
	];

}
