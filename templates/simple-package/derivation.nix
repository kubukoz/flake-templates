{ stdenv, gitignore-source }:
let
  pname = "todo";
  version = "0.0.0";
in
stdenv.mkDerivation {
  inherit pname version;
  src = gitignore-source.lib.gitignoreSource ./.;

  buildPhase = ''
    echo 'echo OK' > result
    chmod +x result
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp result $out/bin/${pname}
  '';

  fixupPhase = "";
}
