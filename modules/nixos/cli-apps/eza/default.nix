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
    cfg = config.${namespace}.cli-apps.eza;
in
{
    options.${namespace}.cli-apps.eza = with types; {
        enable = mkBoolOpt false "Whether or not to enable eza";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            eza
        ];

        homelab.home.extraOptions = {
            programs.eza = {
                enable = true;
                enableZshIntegration = true;
                extraOptions = [
                    "--group-directories-first"
                    "--no-user"
                    "--no-time"
                    "--no-permissions"
                    "--git"
                    "--color=always"
                    "--icons=always"
                ];
            };
        };
    };
}