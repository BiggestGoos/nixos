{

	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

	outputs = { self, nixpkgs }: {
		devShells.x86_64-linux."Tilia-dev" =
		let 
			pkgs = nixpkgs.legacyPackages.x86_64-linux;
		in
		pkgs.mkShell {
		
			packages = with pkgs; [
				git
				cmakeMinimal
				onefetch
			];

			shellHook = ''
				cd $HOME/Dev/Tilia
				git status
				onefetch
			'';

		};
	};

}

