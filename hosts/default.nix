{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    specialArgs = {inherit inputs self;};

    mkSystem = {
      hostname,
      extraModules ? [],
    }:
      nixosSystem {
        inherit specialArgs;
        modules =
          [
            "${self}/system"
            "${self}/hosts/${hostname}.nix"
            inputs.lix-module.nixosModule.default

            {
              home-manager = {
                extraSpecialArgs = specialArgs;
                users.ri.imports = [
                  "${self}/home"
                  "${self}/home/hosts/${hostname}.nix"
                ];
              };
            }
          ]
          ++ extraModules;
      };
  in {
    weatherstation = mkSystem {
      hostname = "weatherstation";
    };
  };
}
