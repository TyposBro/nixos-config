{
  description = "typosbro's NixOS + macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-code-nix.url = "github:sadjow/claude-code-nix";

    # macOS support
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, zen-browser, claude-code-nix, nix-darwin }:
    let
      mkUnstable = system: import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {

      # ── NixOS (Linux) ───────────────────────────────────────────────────────
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [ claude-code-nix.overlays.default ];
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                pkgs-unstable = mkUnstable "x86_64-linux";
                inherit zen-browser;
              };
              users.ched54 = import ./home/linux;
            };
          }
        ];
      };

      # ── macOS (nix-darwin) ──────────────────────────────────────────────────
      # Change system to "x86_64-darwin" if on Intel Mac
      darwinConfigurations.macbook = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/macbook/configuration.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs.overlays = [ claude-code-nix.overlays.default ];
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                pkgs-unstable = mkUnstable "aarch64-darwin";
              };
              users.ched54 = import ./home/darwin;
            };
          }
        ];
      };

    };
}
