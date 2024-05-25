{ config, pkgs, ... }:
pkgs.writeShellApplication {
  name = "scr";
  runtimeInputs = [
    pkgs.wl-clipboard
    pkgs.slurp
    pkgs.grim
    pkgs.coreutils
  ];
  text = let 
    XDG_SCREENSHOTS_DIR = "${config.xdg.usersDirs.extraConfig.XDG_SCREENSHOTS_DIR}";
  in ''
    FILENAME="$(date +'%s_%3Nms.png')"

    wayfreeze & PID=$!; sleep .1; grim -c -g "$(slurp -b "#0000004A" -c "#FFFFFF8A")" "${XDG_SCREENSHOTS_DIR}/$FILENAME"; kill $PID

    wl-copy < "${XDG_SCREENSHOTS_DIR}/$FILENAME"
  '';
}
