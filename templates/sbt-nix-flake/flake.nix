{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-21.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.sbt-derivation.url = "github:zaninime/sbt-derivation";
  inputs.gitignore-source.url = "github:hercules-ci/gitignore.nix";
  inputs.gitignore-source.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, flake-utils, sbt-derivation, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        # Override JRE used by the sbt package
        set-jdk = final: prev: rec {
          jre = prev.openjdk11;
        };
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ set-jdk sbt-derivation.overlay ];
        };
      in
      {
        defaultPackage = pkgs.callPackage ./derivation.nix { inherit (inputs) gitignore-source; };
        checks = {
          test-app =
            pkgs.runCommandNoCC
              "test-app-startup"
              { buildInputs = [ self.defaultPackage.${system} ]; }
              "example > $out";
        };
      }
    );
}
