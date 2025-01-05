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
    cfg = config.${namespace}.desktop.addons.foot;
in
{
    options.${namespace}.desktop.addons.foot = with types; {
        enable = mkBoolOpt true "Whether or not to enable foot.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            foot
        ];

        homelab.home.extraOptions = {
            programs.foot.enable = true;
            catppuccin.foot.enable = true;
        };
    };
}