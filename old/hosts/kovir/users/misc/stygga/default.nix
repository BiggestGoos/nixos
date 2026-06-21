{ pkgs, lib, ... }:
{

	users = {

		groups.stygga = {};

		users = {

			goos.extraGroups = [ "libvirtd" "stygga" ];

		};

	};

	environment = {
    	systemPackages = [ 
    		(pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        	qemu-system-x86_64 \
        	-bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
        	"$@"
      		'')
    	];
    };

	programs.virt-manager.enable = true;

	virtualisation = {

		libvirtd = 
		let

			patched = pkgs.qemu.overrideAttrs (final: previous: {

				patches = previous.patches ++ [
					(
						pkgs.fetchpatch {
							url = "https://github.com/patchew-project/qemu/commit/ab2facbb609b2ff2d667bebbd97097d983a2970c.patch";
							sha256 = "06lmd9d2l1slki7crywfh87rhyfwkjvwq23jmji8qkp0hsn5jwnd";
						}
					)
					(
						pkgs.fetchpatch {
							url = "https://github.com/patchew-project/qemu/commit/d723d575f042c15093cfc852508cd3665030be83.patch";
							sha256 = "06ns5r2nw3jyk6wgmsmwsgb3fgja8lip13hz4sg25ifgmwa07vbl";
						}
					)
					(
						pkgs.fetchpatch {
							url = "https://github.com/patchew-project/qemu/commit/94241302d8a6aa5248aee93771da19b22aa26789.patch";
							sha256 = "10cl03s9w7bqwiv75vbv5x62wr61my3ssqjzxizq6njb8ivjrgps";
						}
					)
					(
						pkgs.fetchpatch {
							url = "https://github.com/patchew-project/qemu/commit/8c170219beabb86de787cf04b1402801305e7144.patch";
							sha256 = "1kcy3x8maydk9095rdkb5ssakwcka41vb4a6gi9cafvfn1469l29";
						}
					)
					(
						pkgs.fetchpatch {
							url = "https://github.com/patchew-project/qemu/commit/8200aa8a1addd69ec04062b1fd38eb54f8a651cb.patch";
							sha256 = "1icwn5vkcz79284r2cyd4fj5gcya1ba6c3fham3v7qq8z7kfgbkk";
						}
					)
					(
						pkgs.fetchpatch {
							url = "https://github.com/patchew-project/qemu/commit/d831eb2804f44a449d04b2c4bdabf8dd4fde949b.patch";
							sha256 = "0qlkwh6igxfkhxrzck9r3ahsf92g6qyk4nx48lpv68gihpcybzyj";
						}
					)
					(
						pkgs.fetchpatch {
							url = "https://github.com/patchew-project/qemu/commit/74eab6f0707a24cf2c4b59b5b8d6f92f42b7e271.patch";
							sha256 = "0ic3aiyzjfc3qxgf1djj64bckmcf77qi05q7lmgcqbhbllyq0xvk";
						}
					)
					(
						pkgs.fetchpatch {
							url = "https://github.com/patchew-project/qemu/commit/83ae5ca851a92535f888c3b8b44e95810b2eceed.patch";
							sha256 = "0wsqg845bmp7cfxb4slwr07hn83ghfin3bpk0janxfskhwgwwcb9";
						}
					)
					/*(
						pkgs.fetchpatch {
							url = "https://github.com/patchew-project/qemu/commit/83ae5ca851a92535f888c3b8b44e95810b2eceed.patch";
							sha256 = "0wsqg845bmp7cfxb4slwr07hn83ghfin3bpk0janxfskhwgwwcb9";
						}
					)*/
				];

			});

		in
		{

			enable = true;

			qemu.package = patched;

		};

	};

}
