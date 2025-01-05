{
    options,
    config,
    lib,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace}; let
    cfg = config.${namespace}.suites.common-desktop;
in
{
    options.${namespace}.suites.common-desktop = with types; {
        enable = mkBoolOpt false "Whether or not to enable common-desktop configuration.";
    };

    config = mkIf cfg.enable {
        
        homelab = {
            apps = {
                alacritty = enabled;
                kitty = enabled;
                discord = enabled;
                teams = enabled;
                slack = enabled;
                brave = enabled;
            };
        };
    };
}