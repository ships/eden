{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system}.vm = pkgs.darwin.linux-builder.override {
      modules = [
        ({ lib, ... }: {
          # nix.settings.sandbox = false;
        })
      ];
    };
  };
}
