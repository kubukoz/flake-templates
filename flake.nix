{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-21.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }: {
    templates.sbt-nix = {
      path = ./templates/sbt-nix;
      description = ''
        An sbt project built in a Nix flake.
        This template is inspired by https://github.com/gvolpe/sbt-nix.g8
        and uses https://github.com/zaninime/sbt-derivation just like the original, but it's a Flake template.'';
    };
  } // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      lib = import ./lib.nix { inherit pkgs; };
    in
    {
      checks = {
        sbt-nix-template-check = lib.check-template { templateName = "sbt-nix"; inherit self; };
      };
    });
}
