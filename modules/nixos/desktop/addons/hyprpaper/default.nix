{
    options,
    lib,
    config,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.desktop.addons.hyprpaper;
in
{
    options.${namespace}.desktop.addons.hyprpaper = with types; {
        enable = mkBoolOpt false "Whether or not to enable HyprPaper.";
    };

    config = mkIf cfg.enable {
        homelab.home.extraOptions = {
            services.hyprpaper = {
                enable = true;

                settings = {
                    ipc = "on";
                    splash = true;
                    splash_offset = 2.0;

                    preload = [
                        "/home/torkel/Pictures/Wallpapers/dominik-mayer-7.jpg"
                        "/home/torkel/Pictures/Wallpapers/dominik-mayer-22.jpg"
                        "/home/torkel/Pictures/Wallpapers/girls-stars.png"
                        "/home/torkel/Pictures/Wallpapers/samurai.jpg"
                        "/home/torkel/Pictures/mistyforrest.jpg"
                    ];

                    wallpaper = [
                        ",/home/torkel/Pictures/mistyforrest.jpg"
                    ];
                };
            };
        };
    };
}