{
  description = "Jaap986's NixOS flake for gaming, HTPC, laptop, NAS, and installer hosts";

  # ============================================================================
  # Inputs Configuration
  # ============================================================================
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    betterfox = {
      url = "github:yokoffing/Betterfox/150.0";
      flake = false;
    };
    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme/v149.1";
      flake = false;
    };

  };

  # ============================================================================
  # Outputs Configuration
  # ============================================================================
  outputs = { self, nixpkgs, home-manager, jovian, betterfox, firefox-gnome-theme, ... }@inputs:
    let
      # Import the generateNixosConfig function
      generateNixosConfig = import ./generate-nixos-config.nix;

      # Standard module sets for different system types
      standardGamingModules = [
        jovian.nixosModules.jovian
        { custom.gaming.steam.enable = true; }
      ];

      # Define the systems for which configurations will be generated
      systems = {
        steambox = {
          extraModules = standardGamingModules;
        };
        steamdeck = {
          extraModules = standardGamingModules;
        };
        ally = {
          extraModules = standardGamingModules;
        };

      };

      installerConfiguration = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inputs = {
            inherit self nixpkgs home-manager jovian betterfox firefox-gnome-theme;
          };
        };
        modules = [
          ./nixos/installer
        ];
      };

    in {
      # Generate NixOS configurations for each system
      nixosConfigurations = (nixpkgs.lib.mapAttrs (name: config:
        generateNixosConfig {
          inputs = {
            inherit self nixpkgs home-manager jovian betterfox firefox-gnome-theme;
          };
          name = name;
          system = config.system or "x86_64-linux";
          extraArgs = config.extraArgs or { };
          optionalModules = config.extraModules or [ ];
        }) systems) // {
          installer = installerConfiguration;
        };
    };
}
