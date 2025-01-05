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
    cfg = config.${namespace}.suites.common;
in
{
    options.${namespace}.suites.common = with types; {
        enable = mkBoolOpt false "Whether or not to enable common configuration.";
    };

    config = mkIf cfg.enable {
        catppuccin.enable = true;

        homelab = {
            system = {
                boot.efi = enabled;
                fonts = enabled;
                i18n = enabled;
                time = enabled;
                xkb = enabled;
            };
            
            cli-apps = {
                fzf = enabled;
                bat = enabled;
                eza = enabled;
                zoxide = enabled;
                ripgrep = enabled;
                yazi = enabled;
                delta = enabled;
                tlrc = enabled;
                btop = enabled;
                slack = enabled;
            };
        };
    };
}