{ pkgs, ... }:

let
  marketplace = pkgs.vscode-utils.extensionFromVscodeMarketplace;
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      # Theme
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons

      # Git
      eamodio.gitlens

      # Formatting & linting
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint

      # Editor enhancements
      vscodevim.vim
      christian-kohler.path-intellisense
      streetsidesoftware.code-spell-checker
      formulahendry.auto-rename-tag
      formulahendry.auto-close-tag
      usernamehw.errorlens
      meganrogge.template-string-converter
      editorconfig.editorconfig
      gruntfuggly.todo-tree

      # Languages
      ms-python.python
      ms-python.vscode-pylance
      bbenoist.nix
      yzhang.markdown-all-in-one

      # Kotlin / Android
      mathiasfrohlich.kotlin
      vscjava.vscode-java-pack
      vscjava.vscode-java-debug
      vscjava.vscode-gradle

      # React Native / TypeScript
      bradlc.vscode-tailwindcss
      christian-kohler.npm-intellisense
      yoavbls.pretty-ts-errors
      naumovs.color-highlight
      mikestead.dotenv
      wix.vscode-import-cost
      firsttris.vscode-jest-runner
    ] ++ [
      # Marketplace extensions (not in nixpkgs)
      (marketplace {
        name = "vscode-react-native";
        publisher = "msjsdiag";
        version = "1.13.0";
        sha256 = "0s0npjnzqj3g877b9kqgc07dipww468sfbiwnf55yvvcxyhb7g6f";
      })
      (marketplace {
        name = "es7-react-js-snippets";
        publisher = "dsznajder";
        version = "4.4.3";
        sha256 = "1xyhysvsf718vp2b36y1p02b6hy1y2nvv80chjnqcm3gk387jps0";
      })
    ];

    profiles.default.userSettings = {
      # Theme
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";

      # Font
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
      "editor.fontSize" = 14;
      "editor.fontLigatures" = true;
      "editor.lineHeight" = 1.6;

      # Editor behavior
      "editor.formatOnSave" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.tabSize" = 2;
      "editor.wordWrap" = "on";
      "editor.cursorStyle" = "line";
      "editor.cursorBlinking" = "smooth";
      "editor.smoothScrolling" = true;
      "editor.minimap.enabled" = false;

      # Terminal
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font'";
      "terminal.integrated.fontSize" = 14;

      # Window
      "window.titleBarStyle" = "custom";
      "workbench.startupEditor" = "none";
      "breadcrumbs.enabled" = false;

      # Git
      "git.autofetch" = true;
      "gitlens.mode.active" = "zen";

      # TypeScript
      "typescript.suggest.autoImports" = true;
      "typescript.updateImportsOnFileMove.enabled" = "always";
      "javascript.suggest.autoImports" = true;
      "javascript.updateImportsOnFileMove.enabled" = "always";

      # Per-language Prettier formatters
      "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[javascriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";

      # ESLint
      "eslint.validate" = [ "typescript" "typescriptreact" "javascript" "javascriptreact" ];

      # Emmet — expand abbreviations in JSX
      "emmet.includeLanguages" = {
        "javascript" = "javascriptreact";
        "typescript" = "typescriptreact";
      };
      "emmet.triggerExpansionOnTab" = true;

      # Tailwind CSS / NativeWind
      "tailwindCSS.includeLanguages" = {
        "typescriptreact" = "html";
        "javascriptreact" = "html";
      };
      "tailwindCSS.classAttributes" = [ "class" "className" "tw" "style" ];
      "tailwindCSS.experimental.classRegex" = [
        "className\\s*:\\s*['\"]([^'\"]*)"
        "tw`([^`]*)"
      ];

      # File associations
      "files.associations" = {
        "*.tsx" = "typescriptreact";
        "*.jsx" = "javascriptreact";
      };

      # Search & watcher exclusions
      "search.exclude" = {
        "**/node_modules" = true;
        "**/ios/Pods" = true;
        "**/android/build" = true;
        "**/.expo" = true;
        "**/dist" = true;
      };
      "files.watcherExclude" = {
        "**/node_modules/**" = true;
        "**/ios/Pods/**" = true;
        "**/android/build/**" = true;
        "**/.expo/**" = true;
        "**/dist/**" = true;
      };

      # Error Lens
      "errorLens.enabledDiagnosticLevels" = [ "error" "warning" ];

      # Todo Tree
      "todo-tree.general.tags" = [ "TODO" "FIXME" "HACK" "BUG" ];

      # Vim
      "vim.leader" = "<space>";
      "vim.useSystemClipboard" = true;
      "vim.hlsearch" = true;
      "vim.smartRelativeLine" = true;
      "vim.highlightedyank.enable" = true;
      "vim.handleKeys" = {
        "<C-a>" = false; # select all
        "<C-c>" = false; # copy
        "<C-v>" = false; # paste
        "<C-x>" = false; # cut
        "<C-z>" = false; # undo
        "<C-f>" = false; # find
      };

      # Vim normal mode — leader keybindings
      "vim.normalModeKeyBindingsNonRecursive" = [
        # File / explorer
        { before = [ "<leader>" "e" ]; commands = [ "workbench.action.toggleSidebarVisibility" ]; }
        { before = [ "<leader>" "f" "f" ]; commands = [ "workbench.action.quickOpen" ]; }
        { before = [ "<leader>" "f" "g" ]; commands = [ "workbench.action.findInFiles" ]; }
        { before = [ "<leader>" "f" "s" ]; commands = [ "workbench.action.files.save" ]; }

        # Splits
        { before = [ "<leader>" "v" ]; commands = [ "workbench.action.splitEditor" ]; }
        { before = [ "<leader>" "s" ]; commands = [ "workbench.action.splitEditorDown" ]; }

        # Split navigation
        { before = [ "<C-h>" ]; commands = [ "workbench.action.focusLeftGroup" ]; }
        { before = [ "<C-l>" ]; commands = [ "workbench.action.focusRightGroup" ]; }
        { before = [ "<C-j>" ]; commands = [ "workbench.action.focusBelowGroup" ]; }
        { before = [ "<C-k>" ]; commands = [ "workbench.action.focusAboveGroup" ]; }

        # Buffers / tabs
        { before = [ "<leader>" "b" "d" ]; commands = [ "workbench.action.closeActiveEditor" ]; }
        { before = [ "<leader>" "b" "o" ]; commands = [ "workbench.action.closeOtherEditors" ]; }
        { before = [ "L" ]; commands = [ "workbench.action.nextEditor" ]; }
        { before = [ "H" ]; commands = [ "workbench.action.previousEditor" ]; }

        # LSP / code actions
        { before = [ "g" "d" ]; commands = [ "editor.action.revealDefinition" ]; }
        { before = [ "g" "r" ]; commands = [ "editor.action.goToReferences" ]; }
        { before = [ "g" "i" ]; commands = [ "editor.action.goToImplementation" ]; }
        { before = [ "g" "t" ]; commands = [ "editor.action.goToTypeDefinition" ]; }
        { before = [ "K" ]; commands = [ "editor.action.showHover" ]; }
        { before = [ "<leader>" "c" "a" ]; commands = [ "editor.action.quickFix" ]; }
        { before = [ "<leader>" "r" "n" ]; commands = [ "editor.action.rename" ]; }

        # Diagnostics
        { before = [ "]" "d" ]; commands = [ "editor.action.marker.next" ]; }
        { before = [ "[" "d" ]; commands = [ "editor.action.marker.prev" ]; }
        { before = [ "<leader>" "d" "d" ]; commands = [ "workbench.actions.view.problems" ]; }

        # Terminal
        { before = [ "<leader>" "t" ]; commands = [ "workbench.action.terminal.toggleTerminal" ]; }

        # React Native
        { before = [ "<leader>" "r" "s" ]; commands = [ "reactNative.runExpoWeb" ]; }
        { before = [ "<leader>" "r" "a" ]; commands = [ "reactNative.runAndroid" ]; }
        { before = [ "<leader>" "r" "i" ]; commands = [ "reactNative.runIos" ]; }

        # Git
        { before = [ "<leader>" "g" "s" ]; commands = [ "workbench.view.scm" ]; }
        { before = [ "<leader>" "g" "b" ]; commands = [ "gitlens.toggleFileBlame" ]; }
      ];

      # Vim visual mode
      "vim.visualModeKeyBindingsNonRecursive" = [
        # Stay in visual mode after indent
        { before = [ ">" ]; commands = [ "editor.action.indentLines" ]; }
        { before = [ "<" ]; commands = [ "editor.action.outdentLines" ]; }
        # Move lines up/down
        { before = [ "J" ]; commands = [ "editor.action.moveLinesDownAction" ]; }
        { before = [ "K" ]; commands = [ "editor.action.moveLinesUpAction" ]; }
      ];
    };

  };
}
