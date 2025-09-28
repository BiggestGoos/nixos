{ szy, pkgs, ... }:
{

	imports = [
		(szy.utils.fromShared "users/desktops/plasma")
	];

	/*"${szy}".profiles.base.branches.desktop.branches.plasma.branches = {

		test.configuration = {
	
			environment.systemPackages = [
				pkgs.onefetch
			];
			
		};
		
		test2.configuration = {

			programs.firefox.enable = true;

		};

	};*/

}
