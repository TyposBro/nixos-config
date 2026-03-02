{ ... }:

{
  xdg.configFile."zed/settings.json".text = builtins.toJSON {
    # Vim mode
    vim_mode = true;

    # Theme
    theme = {
      mode = "dark";
      dark = "Catppuccin Mocha";
      light = "Catppuccin Latte";
    };

    # Font
    buffer_font_family = "JetBrainsMono Nerd Font";
    buffer_font_size = 14;
    buffer_font_features = { calt = true; liga = true; };

    # UI
    ui_font_family = "JetBrainsMono Nerd Font";
    ui_font_size = 14;
    tab_size = 2;
    minimap = { show = "never"; };
    scrollbar = { show = "auto"; };
    cursor_shape = "bar";

    # Terminal
    terminal = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 14;
      shell = { program = "fish"; };
    };

    # Editor behavior
    format_on_save = "on";
    autosave = "on_focus_change";

    # Auto-install extensions (Zed fetches these on first launch)
    auto_install_extensions = {
      catppuccin = true;
      kotlin = true;
      nix = true;
      git-firefly = true;
    };

    # Language overrides
    languages = {
      Kotlin = {
        tab_size = 4;
      };
    };
  };
}
