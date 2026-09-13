{
  szy,
  lib,
  config,
  pkgs,
  ...
}:
(szy config).objects.make {

  inherits = [
    [
      "programs"
      "shell"
    ]
  ];

  name = "zsh";
  namespace = [ "programs" ];

  /*
    variable =
    	{

    		program.arguments =
    		{
    			runCommand.args = [ "-c" ];
    			interactive.args = [ "-i" ];
    		};

    	};
  */

  constant.type = "cli";

  output.config = {

    programs.zsh = {
      enable = true;
    };

  };

}
