{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = false;

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
      rust-lang.rust-analyzer
      tamasfe.even-better-toml

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
      "git.enableSmartCommit" = true;       # commit all changes without staging prompt
      "git.confirmSync" = false;            # no push/pull confirmation
      "git.postCommitCommand" = "none";     # don't prompt to sync after commit
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

      # Rust
      "rust-analyzer.check.command" = "clippy";
      "rust-analyzer.inlayHints.parameterHints.enable" = false;
      "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
      "[rust]"."editor.formatOnSave" = true;
      "[toml]"."editor.defaultFormatter" = "tamasfe.even-better-toml";

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

    };

  };
}
