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
    cfg = config.${namespace}.cli-apps.zoxide;
in
{
    options.${namespace}.cli-apps.zoxide = with types; {
        enable = mkBoolOpt false "Whether or not to install zoxide.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            zoxide
        ];

        homelab.home.extraOptions = {
            programs.zoxide = {
                enable = true;
                enableZshIntegration = true;
            };
        };
    };
}