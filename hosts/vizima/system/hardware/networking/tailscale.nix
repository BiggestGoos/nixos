{

	services.tailscale =
	{

		enable = true;

		# We must use systemd-resolved, according to this: https://github.com/tailscale/tailscale/issues/4254

	};

}
