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

    # Latest Claude Code (always up-to-date, ahead of nixpkgs)
    claude-code-nix.url = "github:sadjow/claude-code-nix";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, zen-browser, claude-code-nix }:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos/configuration.nix
          {
            # Apply claude-code overlay so pkgs.claude-code uses the flake version
            nixpkgs.overlays = [ claude-code-nix.overlays.default ];

            environment.systemPackages = [
              zen-browser.packages.${system}.default
              pkgs-unstable.antigravity
            ];
          }
        ];
      };
    };
}
