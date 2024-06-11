{
  lib,
  fetchFromGitHub,
  unstableGitUpdater,
  buildLua,
  nodePackages,
  jq,
  xidel,
  coreutils,
  gawk,
}:

buildLua {
  pname = "mpv-webtorrent-hook";
  version = "0-unstable-2024-05-27";

  src = fetchFromGitHub {
    owner = "noctuid";
    repo = "mpv-webtorrent-hook";
    rev = "e5ce4fc29a7a73178772699073c48cf3395ccad6";
    hash = "sha256-szzsXdX0k69qmcbc8vIB/lWNvvOkCu2Y76c+VDuo3/w=";
  };

  passthru.updateScript = unstableGitUpdater { };
  scriptPath = "../../mpv-webtorrent-hook";

  patchPhase = ''
    substituteInPlace webtorrent-wrap.sh \
    --replace "awk" "${lib.getExe gawk}" \
    --replace "jq" "${lib.getExe jq}" \
    --replace "xidel" "${lib.getExe xidel}" \
    --replace "mkdir" "${lib.getExe' coreutils ''mkdir'' }" \
    --replace "nohup" "${lib.getExe' coreutils ''nohup'' }" \
    --replace "tail" "${lib.getExe' coreutils ''tail'' }" \
    --replace "echo" "${lib.getExe' coreutils ''echo'' }" \

    substituteInPlace webtorrent-speed-printer.sh \
    --replace "awk" "${lib.getExe gawk}" \
    --replace "tail" "${lib.getExe' coreutils ''tail'' }" \
    --replace "echo" "${lib.getExe' coreutils ''echo'' }"

    substituteInPlace main.lua \
    --replace "webtorrent-wrap.sh" "$out/share/mpv/scripts/webtorrent-wrap.sh" \
    --replace "webtorrent-speed-printer.sh" "$out/share/mpv/scripts/webtorrent-speed-printer.sh" \
  '';

  postInstall = ''
    mkdir -p $out/share/mpv/scripts
    ln -s $out/share/mpv-webtorrent-hook/main.lua $out/share/mpv/scripts/
  '';
  passthru.scriptName = "main.lua";

  meta = with lib; {
    description = "a wrapper to stream torrents using webtorrent-cli";
    homepage = "https://github.com/noctuid/mpv-webtorrent-hook";
    license = licenses.gpl3Only;
    maintainers = with lib.maintainers; [ purrpurrn ];
  };
}
