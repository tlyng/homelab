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
    cfg = config.${namespace}.suites.media;
in
{
    options.${namespace}.suites.media = with types; {
        enable = mkBoolOpt false "Whether or not to enable media configuration.";
    };

    config = mkIf cfg.enable {
        
        homelab = {
            apps = {
                freetube = enabled;
                spotify = enabled;
            };

            cli-apps = {
                spotify-player = enabled;
            };
        };
    };
}