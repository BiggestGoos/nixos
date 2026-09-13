{

  plugins.toggleterm = {

    enable = true;

  };

  keymaps = [
    {
      key = "<C-'>";
      action = "<cmd>ToggleTerm<cr>";
      options = {
        desc = "Open Terminal";
      };
    }
  ];

}
