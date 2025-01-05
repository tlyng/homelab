{
    config,
    lib,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.desktop.addons.hyprlock;
in
{
    options.${namespace}.desktop.addons.hyprlock = with types; {
        enable = mkBoolOpt false "Whether or not to enable HyprLock.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            hyprlock
        ];

        homelab.home.extraOptions = {
            programs.hyprlock = {
                enable = true;
                settings = {
                    general = {
                        monitor = "";
                        disable_loading_bar = false;
                        # grace = 300;
                        hide_cursor = true;
                        no_fade_in = false;
                    };

                    background = [
                        {
                            path = "/home/torkel/Pictures/Wallpapers/girls-stars.png";
                            blur_passes = 2;
                            blur_size = 8;
                        }
                    ];

                    input-field = [
                        {
                            size = "300, 50";
                            position = "0, -80";
                            monitor = "";
                            dots_center = true;
                            fade_on_empty = true;
                            placeholder_text = "<i>Password...</i>";
                            shadow_passes = 2;
                        }
                    ];
                };
            };
            catppuccin.hyprlock.enable = true;
        };
    };
}
