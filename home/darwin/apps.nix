{ lib, ... }:

{
  # macOS-specific fish aliases
  programs.fish.shellAliases = {
    nr  = "sudo darwin-rebuild switch --flake ~/nixos-config#macbook";
    nru = "cd ~/nixos-config && nix flake update && sudo darwin-rebuild switch --flake ~/nixos-config#macbook";
  };

  # Remap Ctrl+Arrow to do what CMD+Arrow used to do (line/document navigation)
  # since CMD+Arrow is now used by AeroSpace for window focus
  home.file."Library/KeyBindings/DefaultKeyBinding.dict".text = ''
    {
      "^\UF702" = "moveToBeginningOfLine:";
      "^\UF703" = "moveToEndOfLine:";
      "^\UF700" = "moveToBeginningOfDocument:";
      "^\UF701" = "moveToEndOfDocument:";
      "^$\UF702" = "moveToBeginningOfLineAndModifySelection:";
      "^$\UF703" = "moveToEndOfLineAndModifySelection:";
      "^$\UF700" = "moveToBeginningOfDocumentAndModifySelection:";
      "^$\UF701" = "moveToEndOfDocumentAndModifySelection:";
    }
  '';

  # Ghostty macOS overrides
  xdg.configFile."ghostty/config".text = lib.mkAfter ''
    macos-titlebar-style = tabs
    keybind = ctrl+left=text:\x01
    keybind = ctrl+right=text:\x05
  '';
}
