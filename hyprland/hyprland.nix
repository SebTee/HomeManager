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
      "hyprpaper"
      "waybar"
    ];

    input.kb_layout = "gb";

    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
    };

    bind =
      [
        # open apps
        "$mod, Return, exec, $terminal"
        "$mod SHIFT, Return, exec, $fileManager"
        "$mod, Space, exec, $menu"
        "$mod, W, exec, $browser"

        # lock screen
        "$mod, Escape, exec, hyprlock"

        # close window
        "$mod, Q, killactive,"
        "$mod SHIFT, Q, forcekillactive,"

        # float & fullscreen
        "$mod, F, togglefloating,"
        "$mod SHIFT, F, fullscreen,"

        # close hyprland
        "$mod SHIFT, X, exit,"

        # scroll workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ]
      ++ (
        # workspaces
        builtins.concatLists (builtins.genList (i:
            let ws = if i == 0 then 10 else i;
            in [
              "$mod, ${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, ${toString i}, movetoworkspace, ${toString ws}"
              "$mod SHIFT CTRL, ${toString i}, movetoworkspacesilent, ${toString ws}"
            ]
          )
          10)
      )
      ++ (
        # Window selection & movement
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

    bindel = [
      # Laptop multimedia keys for volume and LCD brightness
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];

    bindl = [
      # playerctl controls
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
  home.file = {
    ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
    ".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    ".config/hypr/wallpapers".source = ./wallpapers;
  };
}