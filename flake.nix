{
  description = "Emacs and Nix configuration for WSL";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/master"; #Maybe change to unstable!!!
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    myfonts.url = "github:jeslie0/fonts";
    myfonts.inputs.nixpkgs.follows = "nixpkgs";

    # This is a bleeding edge version of emacs. Sometimes, it doesn't get pulled from Cachix...
    emacs-overlay.url = "github:nix-community/emacs-overlay/5a16283b229aa4e7403a35b01ef2cc538c33dc03";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager,  ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let pkgs = nixpkgs.legacyPackages.${system};
          lib = nixpkgs.lib;
      in
        {
      homeManagerConfigurations = {
        james = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "jgl";
          homeDirectory = "/home/jgl";
          configuration = {
            imports = [ (import ./home.nix self) ];
          };
        };
      };
        }
    );
}
