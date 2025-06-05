{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    audacity
    discord
    nodejs
    obs-studio
    vscode
    firefox
    chromium
    android-studio
    spotify
    obsidian
    galaxy-buds-client
    qbittorrent
    jetbrains.idea-ultimate
    jetbrains.webstorm
    jetbrains.rust-rover
  ];
}
