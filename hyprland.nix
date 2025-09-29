{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "alacritty";
    "$browser" = "firefox";
    "$fileManager" = "pcmanfm";
    "$menu" = "wofi --show drun";

    exec-once = [
      "hyprctl setcursor Adwaita 24"
      "waybar"
    ];

    # env = [
    #   "QT_STYLE_OVERRIDE, adwaita-dark"
    #   "GDK_BACKEND, wayland, x11, *"
    #   "QT_QPA_PLATFORM, wayland; xcb"
    # ];

    input.kb_layout = "gb";

    bind =
      [
        "$mod, Return, exec, $terminal"
        "$mod SHIFT, Return, exec, $fileManager"
        "$mod, Space, exec, $menu"
        "$mod, W, exec, $browser"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen,"
        "$mod SHIFT, X, exit,"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = if i == 0 then 10 else i;
            in [
              "$mod, ${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, ${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          10)
      )
      ++ (
        builtins.concatMap (i: 
          let 
            size = 20;
            sizeAdjustment = {
              l = {x = -1; y = 0;};
              r = {x = 1; y = 0;};
              u = {x = 0; y = -1;};
              d = {x = 0; y = 1;};
            }."${i.dir}";
          in [
            "$mod, ${i.key}, movefocus, ${i.dir}"
            "$mod SHIFT, ${i.key}, movewindow, ${i.dir}"
            "$mod CTRL, ${i.key}, resizeactive, ${toString (sizeAdjustment.x * size)} ${toString (sizeAdjustment.y * size)}"
          ])
          [
            {key = "H";    dir = "l";} {key = "J";    dir = "d";} {key = "K";  dir = "u";} {key = "L";     dir = "r";}
            {key = "Left"; dir = "l";} {key = "Down"; dir = "d";} {key = "Up"; dir = "u";} {key = "Right"; dir = "r";}
          ]
      );
  };
}