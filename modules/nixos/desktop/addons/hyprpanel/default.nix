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
    cfg = config.${namespace}.desktop.addons.hyprpanel;
in
{
    options.${namespace}.desktop.addons.hyprpanel = with types; {
        enable = mkBoolOpt false "Whether or not to enable HyprPanel.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            grimblast
            libnotify
            libgtop
            bluez
            dart-sass
            wl-clipboard
            upower
            gvfs
        ];

        homelab.home = {
            file.".zsh/switch-layout.sh".source = ./switch-layout.sh;
            extraOptions = {
                imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

                programs.hyprpanel = {
                    enable = true;
                    hyprland.enable = true;
                    theme = "catppuccin_mocha";

                    # Layout
                    layout = {
                        "bar.layouts" = {
                            "0" = {
                                left = [ "dashboard" "workspaces" "windowtitle" ];
                                middle = [ "media" ];
                                right = [ "volume" "network" "battery" "kbinput" "systray" "clock" "notifications" ];
                            };
                        };
                    };

                    settings = {
                        bar.launcher.autoDetectIcon =  true;
                        bar.clock.format = "%a %b %d %H:%M:%S";
                        theme.bar.opacity = 35;
                        theme.osd.location = "right";

                        # Menus
                        menus.clock.weather.location = "Trondheim";

                        # Discord
                        menus.dashboard.shortcuts.left.shortcut3.command = "vesktop";

                        # Spotify
                        menus.dashboard.shortcuts.left.shortcut2.command = "spotify";

                        # Search
                        menus.dashboard.shortcuts.right.shortcut1.command = "fuzzel";
 
                        # Enable GPU
                        menus.dashboard.stats.enable_gpu = true;

                        # Enable keyboard layout switching
                        bar.customModules.kbLayout.rightClick = "$HOME/.zsh/switch-layout.sh";
                        terminal = "kitty";
                    };
                };
            };
        };
    };
}