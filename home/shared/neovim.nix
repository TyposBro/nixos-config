{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      ripgrep
      fd
    ];

    plugins = with pkgs.vimPlugins; [
      # Theme
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = ''
          require("catppuccin").setup({ flavour = "mocha" })
          vim.cmd.colorscheme("catppuccin")
        '';
      }

      # File tree
      nvim-web-devicons
      nui-nvim
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = ''
          require("neo-tree").setup({
            filesystem = { filtered_items = { visible = true } },
          })
          vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>")
        '';
      }

      # Fuzzy finder
      plenary-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "<leader>ff", builtin.find_files)
          vim.keymap.set("n", "<leader>fg", builtin.live_grep)
          vim.keymap.set("n", "<leader>fb", builtin.buffers)
        '';
      }

      # Terminal toggle
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = ''
          require("toggleterm").setup({ size = 15, direction = "horizontal" })
          vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>")
        '';
      }
    ];

    extraLuaConfig = ''
      -- Leader
      vim.g.mapleader = " "

      -- Options
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.clipboard = "unnamedplus"
      vim.opt.mouse = "a"
      vim.opt.termguicolors = true
      vim.opt.signcolumn = "yes"

      -- Exit terminal mode
      vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

      -- Navigate splits
      vim.keymap.set("n", "<C-h>", "<C-w>h")
      vim.keymap.set("n", "<C-j>", "<C-w>j")
      vim.keymap.set("n", "<C-k>", "<C-w>k")
      vim.keymap.set("n", "<C-l>", "<C-w>l")

      -- Clear search highlight
      vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
    '';
  };
}
