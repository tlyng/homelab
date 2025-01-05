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
    cfg = config.${namespace}.cli-apps.ripgrep;
in
{
    options.${namespace}.cli-apps.ripgrep = with types; {
        enable = mkBoolOpt false "Whether or not to install ripgrep.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            ripgrep
        ];

        homelab.home.extraOptions = {
            programs.ripgrep.enable = true;
        };
    };
}