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
    cfg = config.${namespace}.apps.alacritty;
in
{
    options.${namespace}.apps.alacritty = with types; {
        enable = mkBoolOpt false "Whether or not to enable alacritty";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            alacritty
        ];

        homelab.home.extraOptions = {
            programs.alacritty.enable = true;
            catppuccin.alacritty.enable = true;
        };
    };
}