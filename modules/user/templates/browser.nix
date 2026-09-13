{
  szy,
  lib,
  config,
  pkgs,
  ...
}:
(szy config).objects.make.template {

  name = "browser";
  namespace = [ "programs" ];

  inherits = [
    "default"
    "application"
  ];

  output.config =
    {
      variable,
      constant,
      anyObjectEnabled,
      ...
    }:
    let

      default = constant.default.any;
      defaultOpen = default.variable.commands.default.relative;

      scriptName = "${szy}+defaultBrowser";
      script = pkgs.writeShellScriptBin scriptName ''
        exec ${defaultOpen} "$@"
      '';

    in
    anyObjectEnabled {

      xdg.mimeApps = {

        enable = true;

        defaultApplications =
          let
            mimetypes = [
              "text/html"
              "x-scheme-handler/http"
              "x-scheme-handler/https"
              "x-scheme-handler/about"
              "x-scheme-handler/unknown"
            ];
          in
          builtins.listToAttrs (
            builtins.map (mimetype: {
              name = mimetype;
              value = [
                default.variable.entry.default.final.id
              ];
            }) mimetypes
          );

      };

      "${szy}" = {
        variables = {
          BROWSER = {
            value = scriptName;
            override = "force";
          };
          DEFAULT_BROWSER = {
            value = scriptName;
            override = "force";
          };
        };
        packages = [ script ];
      };

    };

}
