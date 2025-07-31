{ szy, ... }: 
{

	services.batsignal = {
		enable = true;
		extraArgs = [
			# Warning 30%
			"-w 30"
			"-W Battery warning"
			# Critical 5%
			"-c 5"
			"-C Battery critical"
			# Danger 2%
			"-d 2"
			"-D systemctl hibernate"
		];
	};

}
