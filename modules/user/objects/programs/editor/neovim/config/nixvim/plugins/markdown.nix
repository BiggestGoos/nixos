{

  plugins.markview = {
    enable = true;

    settings.preview = {
      buf_ignore = [ ];
      hybrid_modes = [
        "i"
        "r"
      ];
      modes = [
        "n"
        "x"
      ];
    };

    settings.latex = {
      enable = true;
      markdown_inline.enable = true;
      inline.enable = true;
      blocks.enabled = true;
    };
  };

}
