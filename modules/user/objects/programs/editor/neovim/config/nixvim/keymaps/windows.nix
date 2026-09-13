{

  keymaps =
    let
      mkSplitNavMap = letter: {
        mode = "n";
        key = "<C-${letter}>";
        action = "<C-w><C-${letter}>";
      };
    in
    [
      (mkSplitNavMap "h")
      (mkSplitNavMap "l")
      (mkSplitNavMap "j")
      (mkSplitNavMap "k")
    ];

}
