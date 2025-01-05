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
    cfg = config.${namespace}.cli-apps.lazygit;
in
{
    options.${namespace}.cli-apps.lazygit = with types; {
        enable = mkBoolOpt false "Whether or not to enable lazygit";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            lazygit
        ];

        homelab.home.extraOptions = {
            programs.lazygit = {
                enable = true;
                settings = {

                };
            };
            catppuccin.lazygit.enable = true;
        };
    };
}