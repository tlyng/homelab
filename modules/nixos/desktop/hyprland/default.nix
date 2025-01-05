{
    options,
    config,
    lib,
    pkgs,
    namespace,
    inputs,
    ...
}:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.desktop.hyprland;
in
{
    options.${namespace}.desktop.hyprland = with types; {
        enable = mkBoolOpt false "Whether or not to enable Hyprland.";
        # package = mkOpt package inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland "The Hyprland package to use.";
        # portalPackage = mkOpt package inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland "The Hyprland portal package to use.";
        package = mkOpt package pkgs.hyprland "The Hyprland package to use.";
        portalPackage = mkOpt package pkgs.xdg-desktop-portal-hyprland "The Hyprland portal package to use.";

        settings = mkOpt attrs { } "Extra Hyprland settings to apply.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            libinput
            playerctl
            brightnessctl
            glib
            gtk3.out
            gnome-control-center
            libdbusmenu-gtk3
            nautilus
            nautilus-python
        ];

        environment.sessionVariables.WLR_NO_HARDWARE_CURSOR = "1";

        security.pam.services.hyprlock = { };

        services.upower = enabled;
        programs.dconf = enabled;

        programs.hyprland = {
            enable = true;
            xwayland.enable = true;
            package = cfg.package;
            portalPackage = cfg.portalPackage;
        };

        services.xserver.enable = true;
        services.displayManager.sddm.enable = true;
        services.displayManager.sddm.wayland.enable = true;
        services.displayManager.sddm.package = pkgs.kdePackages.sddm;
        catppuccin.sddm.enable = true;
        homelab = {
            system.xkb.enable = true;
            desktop.addons = {
                gtk = enabled;
                electron-support = enabled;
                foot = enabled;
                hyprpanel = enabled;
                hyprpaper = enabled;
                hyprlock = enabled;
                hypridle = enabled;
                fuzzel = enabled;
            };
        };


        homelab.home.extraOptions = {
            wayland.windowManager.hyprland = {
                enable = true;

                plugins = with pkgs; [
                    # inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
                    hyprlandPlugins.hyprexpo
                ];

                settings = mkMerge [
                    {
                        "$mainMod" = "SUPER";
                        "$terminal" = "kitty --name=terminal";

                        monitor = [
                          # Default monitor fallback
                          ", 5120x1440@60, auto, 1"
                        ];

                        input = {
                            repeat_delay = 200;
                            follow_mouse = 2;
                            mouse_refocus = false;

                            kb_layout="us,no";
                            kb_options = "caps:escape";

                            touchpad = {
                                natural_scroll = true;
                            };
                        };

                        general = {
                            layout = "master";

                            border_size = 2;
                            gaps_out = 16;
                        };

                        master = {
                            orientation = "center";
                            always_center_master = true;
                        };

                        dwindle = {
                            preserve_split = true;
                            force_split = 2;
                        };

                        misc = {
                            disable_hyprland_logo = true;
                            disable_splash_rendering = true;
                        };

                        gestures = {
                            workspace_swipe = true;
                            workspace_swipe_distance = 100;
                        };

                        bind = [
                          # Hyprland controls
                          "$mainMod_SHIFT, q, exit"
                          "$mainMod_SHIFT, r, forcerendererreload"
                          "$mainMod_SHIFT, e, hyprexpo:expo, toggle"
                          "$mainMod_SHIFT, return, exec, hyprlock"

                          # Window management
                          "$mainMod, h, movefocus, l"
                          "$mainMod, l, movefocus, r"
                          "$mainMod, j, movefocus, d"
                          "$mainMod, k, movefocus, u"
                          "$mainMod, left, movefocus, l"
                          "$mainMod, right, movefocus, r"
                          "$mainMod, up, movefocus, d"
                          "$mainMod, down, movefocus, u"

                          "$mainMod_SHIFT, h, movewindow, l"
                          "$mainMod_SHIFT, l, movewindow, r"
                          "$mainMod_SHIFT, j, movewindow, d"
                          "$mainMod_SHIFT, k, movewindow, u"
                          "$mainMod_SHIFT, left, movewindow, l"
                          "$mainMod_SHIFT, right, movewindow, r"
                          "$mainMod_SHIFT, up, movewindow, d"
                          "$mainMod_SHIFT, down, movewindow, u"

                          "$mainMod, v, togglesplit"
                          "$mainMod, q, killactive"

                          "$mainMod_SHIFT, Space, togglefloating"

                          "$mainMod_SHIFT, s, pin"

                          "$mainMod, f, fullscreen, 0"
                        #   "$mainMod_SHIFT, f, fakefullscreen"

                          # Workspace management
                          "$mainMod, 1, workspace, 1"
                          "$mainMod, 2, workspace, 2"
                          "$mainMod, 3, workspace, 3"
                          "$mainMod, 4, workspace, 4"
                          "$mainMod, 5, workspace, 5"
                          "$mainMod, 6, workspace, 6"
                          "$mainMod, 7, workspace, 7"
                          "$mainMod, 8, workspace, 8"
                          "$mainMod, 9, workspace, 9"
                          "$mainMod, 0, workspace, 10"

                          "$mainMod_SHIFT, 1, movetoworkspace, 1"
                          "$mainMod_SHIFT, 2, movetoworkspace, 2"
                          "$mainMod_SHIFT, 3, movetoworkspace, 3"
                          "$mainMod_SHIFT, 4, movetoworkspace, 4"
                          "$mainMod_SHIFT, 5, movetoworkspace, 5"
                          "$mainMod_SHIFT, 6, movetoworkspace, 6"
                          "$mainMod_SHIFT, 7, movetoworkspace, 7"
                          "$mainMod_SHIFT, 8, movetoworkspace, 8"
                          "$mainMod_SHIFT, 9, movetoworkspace, 9"
                          "$mainMod_SHIFT, 0, movetoworkspace, 10"

                          "$mainMod_SHIFT_Control_L, 1, movetoworkspacesilent, 1"
                          "$mainMod_SHIFT_Control_L, 2, movetoworkspacesilent, 2"
                          "$mainMod_SHIFT_Control_L, 3, movetoworkspacesilent, 3"
                          "$mainMod_SHIFT_Control_L, 4, movetoworkspacesilent, 4"
                          "$mainMod_SHIFT_Control_L, 5, movetoworkspacesilent, 5"
                          "$mainMod_SHIFT_Control_L, 6, movetoworkspacesilent, 6"
                          "$mainMod_SHIFT_Control_L, 7, movetoworkspacesilent, 7"
                          "$mainMod_SHIFT_Control_L, 8, movetoworkspacesilent, 8"
                          "$mainMod_SHIFT_Control_L, 9, movetoworkspacesilent, 9"
                          "$mainMod_SHIFT_Control_L, 0, movetoworkspacesilent, 10"

                        #   # Desktop shell integration
                        #   "$mainMod, s, pass, ^(avalanche-bar).*$"

                          # Programs
                          "$mainMod, T, exec, $terminal"
                          "$mainMod_SHIFT, T, exec, alacritty"
                          "$mainMod, P, exec, fuzzel"
                          "$mainMod, W, exec, brave"
                          "$mainMod_SHIFT, W, exec, firefox"
                        ];

                        # bindm = [
                        #   # Use `wev` to find the keycodes
                        #   "$mainMod, mouse:272, movewindow"
                        #   "$mainMod, mouse:273, resizewindow"
                        # ];

                        # bindl = [
                        #   ", switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, preferred, auto, 1\""
                        #   ", switch:on:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, disable\""
                        # ];

                        binde = [
                            # Media
                            ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
                            ", XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
                            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                            ", code:171, exec, playerctl next"
                            ", code:173, exec, playerctl prev"
                            ", code:172, exec, playerctl play-pause"
                        ];

                        windowrule = [ ];

                        layerrule = [ "noanim, ^avalanche-" ];

                        # Programs to run on startup
                        exec-once =
                        [
                            # "hypridle &"
                            # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
                            # "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
                        ];
                        # ++ optional config.${namespace}.desktop.addons.gtk.enable
                        #     "${cfg.package}/bin/hyprctl setcursor \"${config.${namespace}.desktop.addons.gtk.cursor.name}\" 16";

                        # Decorations
                        decoration = {
                            rounding = 8;
                            # drop_shadow = true;
                            # shadow_ignore_window = false;
                            active_opacity = 1.0;
                            inactive_opacity = 1.0;

                            blur = {
                                enabled = true;
                            };

                            shadow = {
                                enabled = true;
                                ignore_window = false;
                            };
                        };
                    }
                    cfg.settings                    
                ];
            };
            catppuccin.hyprland = enabled;
            catppuccin.hyprlock = enabled;
            catppuccin.cursors = enabled;
        };
    };
}