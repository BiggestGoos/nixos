{

	networking =
	{
		firewall =
		{
			enable = true;

			backend = "nftables";
		};

		nftables.enable = true;
	};

}
