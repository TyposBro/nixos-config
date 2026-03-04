{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # Search tools
      ripgrep
      fd

      # LSP servers
      typescript-language-server
      tailwindcss-language-server
      lua-language-server
      nil # Nix LSP
      pyright

      # Linting & formatting
      vscode-langservers-extracted # eslint LSP, css/json/html LSPs
      eslint_d
      prettierd
      stylua
    ];

    plugins = with pkgs.vimPlugins; [
      # ── Theme ────────────────────────────────────────────────
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = ''
          require("catppuccin").setup({
            flavour = "mocha",
            integrations = {
              cmp = true,
              gitsigns = true,
              treesitter = true,
              neo_tree = true,
              indent_blankline = { enabled = true },
              which_key = true,
              native_lsp = { enabled = true },
            },
          })
          vim.cmd.colorscheme("catppuccin")
        '';
      }

      # ── File Explorer ────────────────────────────────────────
      nvim-web-devicons
      nui-nvim
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = ''
          require("neo-tree").setup({
            filesystem = { filtered_items = { visible = true } },
          })
          vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "File explorer" })
        '';
      }

      # ── Fuzzy Finder ─────────────────────────────────────────
      plenary-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
          vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
          vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
          vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
        '';
      }

      # ── Terminal ──────────────────────────────────────────────
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = ''
          require("toggleterm").setup({ size = 15, direction = "horizontal" })
          vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "Terminal" })
        '';
      }

      # ── Treesitter ───────────────────────────────────────────
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.typescript
          p.tsx
          p.javascript
          p.json
          p.lua
          p.nix
          p.html
          p.css
          p.markdown
          p.markdown_inline
          p.bash
          p.python
          p.vim
          p.vimdoc
          p.yaml
        ]));
        type = "lua";
        config = ''
          require("nvim-treesitter.configs").setup({
            highlight = { enable = true },
            indent = { enable = true },
          })
        '';
      }

      # ── Completion (sources + snippets, no config — must be before cmp) ──
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      friendly-snippets
      lspkind-nvim

      {
        plugin = luasnip;
        type = "lua";
        config = ''
          require("luasnip.loaders.from_vscode").lazy_load()
        '';
      }

      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require("cmp")
          local luasnip = require("luasnip")
          local lspkind = require("lspkind")

          cmp.setup({
            snippet = {
              expand = function(args)
                luasnip.lsp_expand(args.body)
              end,
            },
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
              ["<C-b>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-e>"] = cmp.mapping.abort(),
              ["<CR>"] = cmp.mapping.confirm({ select = true }),
              ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" }),
              ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
              { name = "nvim_lsp" },
              { name = "luasnip" },
            }, {
              { name = "buffer" },
              { name = "path" },
            }),
            formatting = {
              format = lspkind.cmp_format({
                mode = "symbol_text",
                maxwidth = 50,
                ellipsis_char = "...",
              }),
            },
          })
        '';
      }

      # ── LSP ──────────────────────────────────────────────────
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local lspconfig = require("lspconfig")
          local capabilities = require("cmp_nvim_lsp").default_capabilities()

          -- Keymaps on LspAttach
          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
              local opts = { buffer = ev.buf }
              vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
              vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
              vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
              vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
              vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
              vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
              vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
              vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
              vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
              vim.keymap.set("n", "<leader>dd", vim.diagnostic.setloclist, opts)
            end,
          })

          -- Diagnostic display
          vim.diagnostic.config({
            virtual_text = { prefix = "●" },
            signs = true,
            underline = true,
            update_in_insert = false,
            float = { border = "rounded" },
          })

          -- TypeScript / JavaScript (React Native)
          lspconfig.ts_ls.setup({ capabilities = capabilities })

          -- Tailwind CSS / NativeWind
          lspconfig.tailwindcss.setup({
            capabilities = capabilities,
            settings = {
              tailwindCSS = {
                classAttributes = { "class", "className", "tw", "style" },
                experimental = {
                  classRegex = {
                    { "className\\s*:\\s*['\"]([^'\"]*)", "" },
                    { "tw`([^`]*)", "" },
                  },
                },
              },
            },
          })

          -- Lua (Neovim config)
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
                diagnostics = { globals = { "vim" } },
                telemetry = { enable = false },
              },
            },
          })

          -- Nix
          lspconfig.nil_ls.setup({ capabilities = capabilities })

          -- Python
          lspconfig.pyright.setup({ capabilities = capabilities })

          -- ESLint
          lspconfig.eslint.setup({ capabilities = capabilities })
        '';
      }

      # ── Formatting ───────────────────────────────────────────
      {
        plugin = conform-nvim;
        type = "lua";
        config = ''
          require("conform").setup({
            formatters_by_ft = {
              javascript = { "prettierd" },
              javascriptreact = { "prettierd" },
              typescript = { "prettierd" },
              typescriptreact = { "prettierd" },
              json = { "prettierd" },
              css = { "prettierd" },
              html = { "prettierd" },
              markdown = { "prettierd" },
              lua = { "stylua" },
            },
            format_on_save = {
              timeout_ms = 2000,
              lsp_format = "fallback",
            },
          })
          vim.keymap.set({ "n", "v" }, "<leader>cf", function()
            require("conform").format({ async = true, lsp_format = "fallback" })
          end, { desc = "Format" })
        '';
      }

      # ── Linting ──────────────────────────────────────────────
      {
        plugin = nvim-lint;
        type = "lua";
        config = ''
          local lint = require("lint")
          lint.linters_by_ft = {
            javascript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescript = { "eslint_d" },
            typescriptreact = { "eslint_d" },
          }
          vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            callback = function() lint.try_lint() end,
          })
        '';
      }

      # ── Statusline ───────────────────────────────────────────
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require("lualine").setup({
            options = {
              theme = "catppuccin",
              component_separators = { left = "", right = "" },
              section_separators = { left = "", right = "" },
            },
          })
        '';
      }

      # ── Buffer / Tab Bar ─────────────────────────────────────
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          require("bufferline").setup({
            options = {
              diagnostics = "nvim_lsp",
              offsets = {
                { filetype = "neo-tree", text = "File Explorer", highlight = "Directory" },
              },
              separator_style = "slant",
            },
            highlights = require("catppuccin.groups.integrations.bufferline").get(),
          })
          vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
          vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
          vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buffer" })
        '';
      }

      # ── Git Signs ────────────────────────────────────────────
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
          require("gitsigns").setup({
            signs = {
              add          = { text = "│" },
              change       = { text = "│" },
              delete       = { text = "_" },
              topdelete    = { text = "‾" },
              changedelete = { text = "~" },
            },
          })
        '';
      }

      # ── Indent Guides ────────────────────────────────────────
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          require("ibl").setup({
            indent = { char = "│" },
            scope = { enabled = true },
          })
        '';
      }

      # ── Which Key ────────────────────────────────────────────
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          local wk = require("which-key")
          wk.setup({ delay = 300 })
          wk.add({
            { "<leader>f", group = "Find" },
            { "<leader>b", group = "Buffer" },
            { "<leader>c", group = "Code" },
            { "<leader>d", group = "Diagnostics" },
            { "<leader>g", group = "Git" },
            { "<leader>r", group = "Rename" },
          })
        '';
      }

      # ── Editing Enhancements ─────────────────────────────────
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require("nvim-autopairs").setup({})
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        '';
      }

      {
        plugin = nvim-ts-autotag;
        type = "lua";
        config = ''require("nvim-ts-autotag").setup({})'';
      }

      {
        plugin = comment-nvim;
        type = "lua";
        config = ''require("Comment").setup({})'';
      }

      {
        plugin = nvim-surround;
        type = "lua";
        config = ''require("nvim-surround").setup({})'';
      }
    ];

    extraLuaConfig = ''
      -- Leader (must be before plugins)
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

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
      vim.opt.cursorline = true
      vim.opt.scrolloff = 8
      vim.opt.updatetime = 250
      vim.opt.splitright = true
      vim.opt.splitbelow = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.undofile = true

      -- Exit terminal mode
      vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

      -- Navigate splits
      vim.keymap.set("n", "<C-h>", "<C-w>h")
      vim.keymap.set("n", "<C-j>", "<C-w>j")
      vim.keymap.set("n", "<C-k>", "<C-w>k")
      vim.keymap.set("n", "<C-l>", "<C-w>l")

      -- Clear search highlight
      vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")

      -- Save file
      vim.keymap.set("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })

      -- Move lines in visual mode
      vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move down" })
      vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move up" })
    '';
  };
}
