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
    cfg = config.${namespace}.cli-apps.fzf;
in
{
    options.${namespace}.cli-apps.fzf = with types; {
        enable = mkBoolOpt false "Whether or not to enable fzf";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            fzf
        ];

        homelab.home.extraOptions = {
            programs.fzf.enable = true;
            catppuccin.fzf.enable = true;
        };
    };
}