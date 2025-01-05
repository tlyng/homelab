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
    cfg = config.${namespace}.desktop.addons.fuzzel;
in
{
    options.${namespace}.desktop.addons.fuzzel = with types; {
        enable = mkBoolOpt false "Whether or not to enable Fuzzel.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            fuzzel
        ];

        homelab.home.extraOptions = {
            programs.fuzzel.enable = true;
            catppuccin.fuzzel.enable = true; 
        };
    };
}