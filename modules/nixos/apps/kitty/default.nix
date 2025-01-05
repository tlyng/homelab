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
    cfg = config.${namespace}.apps.kitty;
in
{
    options.${namespace}.apps.kitty = with types; {
        enable = mkBoolOpt false "Whether or not to enable kitty";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            kitty
        ];

        homelab.home.extraOptions = {
            programs.kitty = {
                enable = true;
                shellIntegration = {
                    enableZshIntegration = true;
                };
                settings = {
                    font_family = "MesloLGS Nerd Font";
                    background_opacity = 0.85;
                };
            };
            catppuccin.kitty.enable = true;
        };
    };
}