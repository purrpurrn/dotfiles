{ distrobox, bash, makeWrapper
, runCommand }:
runCommand "distrobox" { nativeBuildInputs = [ makeWrapper ]; } ''
  mkdir -p $out/bin
  for f in ${distrobox}/bin/*; do
    echo $out
    makeWrapper $f $out/bin/$(basename $f) --set SHELL ${bash}/bin/bash
  done
  cp -r ${distrobox}/share $out/share
''
