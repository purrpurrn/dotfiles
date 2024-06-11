{ config, pkgs, inputs, ... }: let 
  XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR}";

  scr = pkgs.writeShellApplication {
  name = "scr";
  runtimeInputs = [
    pkgs.wl-clipboard
    pkgs.slurp
    pkgs.grim
    pkgs.coreutils
  ];
  text = ''
    FILENAME="$(date +'%s_%3Nms.png')"

    wayfreeze & PID=$!; sleep .1; grim -c -g "$(slurp -b "#0000004A" -c "#00000000")" "${XDG_SCREENSHOTS_DIR}/$FILENAME"; kill $PID

    wl-copy < "${XDG_SCREENSHOTS_DIR}/$FILENAME"
  '';
}; in {
  home.packages = [
    scr
    pkgs.wayfreeze
  ];
}
