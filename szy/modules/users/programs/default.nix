{ szy, ... }:
{

	imports = [
		(szy.utils.import.internal.shared.from "programs/shell")
		(szy.utils.import.internal.shared.from "programs/editor")
		(szy.utils.import.internal.shared.from "programs/fileManager")
		(szy.utils.import.internal.shared.from "programs/git")
		(szy.utils.import.internal.shared.from "programs/systemMonitor")
		(szy.utils.import.internal.shared.from "programs/steam")
		(szy.utils.import.internal.shared.from "programs/terminalTools")
	];

}
