{ lib, config, szy, ... }:
{

	"${szy}".objects.noteEditor.definitions.obsidian.data.enable = true;

	/*imports = [
		(szy.utils.fromShared "users/user/programs/notes/obsidian")
	];*/

}
