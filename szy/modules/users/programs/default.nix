{ szy, ... }:
{

	imports = [
		(szy.import.internal.shared.from "programs/shell")
		(szy.import.internal.shared.from "programs/editor")
		(szy.import.internal.shared.from "programs/fileManager")
		(szy.import.internal.shared.from "programs/git")
		(szy.import.internal.shared.from "programs/systemMonitor")
		(szy.import.internal.shared.from "programs/steam")
		(szy.import.internal.shared.from "programs/terminalTools")
		(szy.import.internal.shared.from "programs/nh")
	];

}
