{ szy, ... }:
{

	imports = [
		(import (szy.utils.fromShared "internal/shared/programs/terminalTools") { additionalTools = []; })
	];

}
