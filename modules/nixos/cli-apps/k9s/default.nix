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
    cfg = config.${namespace}.cli-apps.k9s;
in
{
    options.${namespace}.cli-apps.k9s = with types; {
        enable = mkBoolOpt false "Whether or not to enable k9s";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            k9s
        ];

        homelab.home.extraOptions = {
            programs.k9s.enable = true;
            catppuccin.k9s.enable = true;
        };
    };
}