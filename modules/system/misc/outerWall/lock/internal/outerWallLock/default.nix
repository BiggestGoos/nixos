{ stdenv, pam, ... }:
stdenv.mkDerivation
{
	pname = "pam-outerWallLock";
	version = "0.1";

	src =./.;

	buildInputs = 
	[ 
		pam 
	];

	buildPhase = ''	
		$CC \
			-fPIC \
			-shared \
			-Wall -Wextra \
			-o pam_outer_wall_lock.so \
			pam_outer_wall_lock.c \
			-lpam
	'';

	installPhase = ''
		mkdir -p $out/lib/security
		cp pam_outer_wall_lock.so $out/lib/security/
	'';
}
