{
  szy,
  config,
  ...
}:
(szy config).objects.make
{
  inherits = [["programs" "editor"]];
  #extends = [ "terminalApplication" ];

  name = "helix";
  namespace = ["programs"];

  constant.type = "cli";

  variable = {
    entry.default.base.locator = "Helix";
  };

  output.config = {
    programs.helix = {
      enable = true;
    };
  };
}
