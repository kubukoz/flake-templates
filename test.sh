#!/bin/bash

TEMPLATES=$(nix flake show --json | nix run nixpkgs#jq ".templates | keys []" -- -r)
for template in $TEMPLATES
do
  echo ">>>> Testing template $template"

  mkdir "testing-$template"
  cd "testing-$template"
  nix flake init --template "../.#$template"
  git init
  git add --all
  nix flake check --print-build-logs

  cd -
  rm -rf "testing-$template"
done
