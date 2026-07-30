{ config, pkgs, inputs, lib, ... }:
{

	imports =
	[
		inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
	];

	nixpkgs.overlays =
	[
		(
			final: prev:
			{
				xrizer = prev.xrizer.overrideAttrs
				(
					old:
					{
						src = inputs.xrizer-inputFix.outPath;
					}
				);
			}
		)
		(
			final: prev:
			{
				wivrn = prev.wivrn.override
				{
					ovrCompatSearchPaths = "${final.xrizer}/lib/xrizer:${final.opencomposite}/lib/opencomposite:${final.vapor}/lib/VapoR";
				};
			}
		)
	];

	services.wivrn =
	{

		#enable = true;
		openFirewall = true;
		
		#autoStart = true;

		highPriority = true;

		/*config =
		{
			enable = true;
			json =
			{

				encoder = 
				[
    				{
      					encoder = "vulkan";
      					codec = "h265";
    				}
    				{
      					encoder = "vulkan";
      					codec = "h265";
    				}
    				{
      					encoder = "vulkan";
      					codec = "h265";
    				}
  				];
  				application = [ pkgs.wayvr ];

				openvr-compat-path = "${pkgs.vapor}/lib/VapoR";
			};
		};*/

		steam =
		{
			#enable = false;
			#importOXRRuntimes = true;
			#package = config.programs.steam.package;
		};

	};

	/*programs.alvr =
	{
		enable = true;
		openFirewall = true;
	};

	services.lact = # TODO: Add decalation for VR mode. TLDR: Make graphics card automatically switch to VR power mode when e.g. wivrn is open.
	{
		enable = true;
	};*/

	/*environment =
	{

		sessionVariables = 
		{
			PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES = "1";
			PRESSURE_VESSEL_FILESYSTEMS_RW = "\${XDG_RUNTIME_DIR}/wivrn/comp_ipc";
		};

		systemPackages = 
		[ 
			pkgs.android-tools
			pkgs.wayvr 
			pkgs.vapor
			#pkgs.xr-chaperone
		];

	};*/

	environment.systemPackages = 
	let

		wrapWithMissingLibraries =
		binaryFile:
		pkgs.writeShellScriptBin (baseNameOf binaryFile) 
		''
			LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.libGL pkgs.libuuid pkgs.vulkan-loader ]}";
			export LD_LIBRARY_PATH
			exec ${binaryFile} "$@";
		'';

		wayvr = wrapWithMissingLibraries (lib.meta.getExe pkgs.wayvr);

	in
	[ 
		wayvr
	];

	# IMPORTANT: SteamVR needs CAP_SYS_NICE to be set for ~/.steam/steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher

}
