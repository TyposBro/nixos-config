{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    audacity
    discord
    nodejs
    obs-studio
    vscode
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
