{ jre, sbt, gitignore-source, makeWrapper, stdenv, lib, coreutils, gawk }:

sbt.mkDerivation rec {
  pname = "example";
  version = "0.1.0";
  depsSha256 = "sha256-c8M6PJ9Cx5jRnCw2b4E/puIh7WhcGVhAS38ZLe7XhME=";

  depsWarmupCommand = ''
    sbt Test/compile
  '';

  nativeBuildInputs = [ makeWrapper ];

  src = lib.sourceByRegex (gitignore-source.lib.gitignoreSource ./.) [
    "^project\$"
    "^project/.*\$"
    "^src\$"
    "^src/.*\$"
    "^build.sbt\$"
  ];

  buildPhase = ''
    sbt stage
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r target/universal/stage/lib $out
    cp target/universal/stage/bin/root $out/bin/${pname}
    wrapProgram $out/bin/${pname} \
      --prefix PATH : "${lib.makeBinPath [ jre coreutils gawk ]}"
  '';
}
