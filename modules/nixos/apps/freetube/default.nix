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
    cfg = config.${namespace}.apps.freetube;
in
{
    options.${namespace}.apps.freetube = with types; {
        enable = mkBoolOpt false "Whether or not to enable freetube";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            freetube
        ];

        homelab.home.extraOptions = {
            programs.freetube.enable = true;
            catppuccin.freetube.enable = true;
        };
    };
}