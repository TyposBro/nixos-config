{
  description = "typosbro's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-code-nix.url = "github:sadjow/claude-code-nix";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, zen-browser, claude-code-nix }:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit hyprland; };
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [ claude-code-nix.overlays.default ];

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit hyprland pkgs-unstable zen-browser; };
              users.ched54 = import ./home/ched54;
            };
          }
        ];
      };
    };
}
