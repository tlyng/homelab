{
    options,
    config,
    pkgs,
    lib,
    namespace,
    ...
}:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.system.time;
in
{
    options.${namespace}.system.time = with types; {
        enable = mkBoolOpt false "Wheter or not to manage timezone configuration";
        timeZone = mkOpt str "Europe/Oslo" "Configured timezone";
    };

    config = mkIf cfg.enable {
        time.timeZone = cfg.timeZone;
    };
}