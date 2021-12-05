{
  outputs = _: {
    templates.sbt-nix = {
      path = ./templates/sbt-nix;
      description = ''
        An sbt project built in a Nix flake.
        This template is inspired by https://github.com/gvolpe/sbt-nix.g8
        and uses https://github.com/zaninime/sbt-derivation just like the original, but it's a Flake template.'';
    };
    templates.simple-package = {
      path = ./templates/simple-package;
      description = ''Simple multi-system Nix flake for a package.'';
    };
  };
}
