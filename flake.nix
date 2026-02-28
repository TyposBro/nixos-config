{
  description = "typosbro's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Zen Browser — not in nixpkgs, uses community flake
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zen-browser }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/nixos/configuration.nix
        {
          environment.systemPackages = [
            zen-browser.packages.x86_64-linux.default
          ];
        }
      ];
    };
  };
}
