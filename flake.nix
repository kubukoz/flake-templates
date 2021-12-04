{
  outputs = _: {
    templates.sbt-nix = {
      path = ./templates/sbt-nix;
      description = "An sbt project built in a Nix flake";
    };
  };
}
