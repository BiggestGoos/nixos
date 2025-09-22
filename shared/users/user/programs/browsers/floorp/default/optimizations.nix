{ variant, lib, config, ... }:
lib.mkIf variant.enabled
{

	# https://gist.github.com/0XDE57/fbd302cef7693e62c769
	# https://gist.github.com/kRHYME7/84ef0f69872eb9b92deb2a0aa4b869bf

	programs.floorp.profiles."${config.home.username}".settings = {

		"webgl.disabled" = false;
		"gfx.webrender.all" = true;
		"webgl.force-enabled" = true;
		"layers.acceleration.force-enabled" = true;
		"layers.offmainthreadcomposition.async-animations" = true;

		"nglayout.initialpaint.delay" = 0;
		"nglayout.initialpaint.delay_in_oopif" = 0;

		"network.http.pipelining" = true;
		"network.http.proxy.pipelining" = true;
		"network.http.proxy.pipelining.ssl" = true;
		"network.http.pipelining.maxrequests" = 25;

		"browser.cache.disk.parent_directory" = "/dev/shm/floorp_cache";

	};

}
