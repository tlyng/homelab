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
    cfg = config.${namespace}.cli-apps.bat;
in
{
    options.${namespace}.cli-apps.bat = with types; {
        enable = mkBoolOpt false "Whether or not to enable bat";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            bat
        ];
    
        homelab.home.extraOptions = {
            programs.bat.enable = true;
            catppuccin.bat.enable = true;
        };
    };
}