{
    options,
    config,
    lib,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.desktop.addons.gtk;
    gdmCfg = config.services.xserver.displayManager.gdm;
in
{
    options.${namespace}.desktop.addons.gtk = with types; {
        enable = mkBoolOpt false "Whether to customize GTK and apply themes.";
    };

    config = mkIf cfg.enable {
        homelab.home.extraOptions = {
            gtk.enable = true;
            catppuccin.gtk.enable = true;
        };
    };
}