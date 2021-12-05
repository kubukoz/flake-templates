{ pkgs }:
{
  check-template = { templateName, self }:
    pkgs.runCommandNoCC "${templateName}-check-init" { buildInputs = [ pkgs.nix_2_4 pkgs.git ]; } ''
      mkdir -p .home/.config/nix

      HOME=$(pwd)/.home nix flake init --template ${self}#${templateName} --extra-experimental-features 'nix-command flakes'

      git init
      git add --all

      HOME=$(pwd)/.home nix flake check --print-build-logs --extra-experimental-features 'nix-command flakes' > $out
    '';
}
