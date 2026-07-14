{ inputs, name, extraArgs, optionalModules, system ? "x86_64-linux" }:

let
  # Use the provided system or default to x86_64-linux
  pkgs = inputs.nixpkgs;

  homeManager = inputs.home-manager;
  defaultModules = [ ./modules ];

in pkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs extraArgs; };
  modules = [
    ./nixos/${name}
    homeManager.nixosModules.home-manager
    {

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

      # Apply shared configuration for the main user
      home-manager.users.gamer = import ./home/systems/${name}.nix;

      # Pass shared arguments and any additional args
      home-manager.extraSpecialArgs = extraArgs // { inherit inputs; };
    }

  ] ++ optionalModules ++ defaultModules;
}
