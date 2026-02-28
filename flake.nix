{
  description = "typosbro's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Zen Browser — not in nixos-25.05, uses community flake
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, zen-browser }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/nixos/configuration.nix
        ({ pkgs, ... }: {
          # Packages from unstable channel
          environment.systemPackages = [
            zen-browser.packages.x86_64-linux.default
            nixpkgs-unstable.legacyPackages.x86_64-linux.antigravity
          ];
        })
      ];
    };
  };
}
