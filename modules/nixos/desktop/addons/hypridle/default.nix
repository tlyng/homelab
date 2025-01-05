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
    cfg = config.${namespace}.desktop.addons.hypridle;
in
{
    options.${namespace}.desktop.addons.hypridle = with types; {
        enable = mkBoolOpt false "Whether or not to enable hypridle.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            hypridle
        ];

        homelab.home.extraOptions = {
            services.hypridle = {
                enable = true;
                settings = {
                    general = {
                        lock_cmd = "hyprlock";
                        after_sleep_cmd = "hyprctl dispatch dpms on";
                        ignore_dbus_inhibit = false;
                        ignore_systemd_inhibit = false;
                    };

                    listener = [
                        {
                            timeout = 300;
                            on-timeout = "hyprlock";
                        }
                        {
                            timeout = 360;
                            on-timeout = "hyprctl dispatch dpms off";
                            on-resume = "hyprctl dispatch dpms on";
                        }
                    ];
                };
            };
        };
    };
}
