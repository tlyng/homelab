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
    cfg = config.${namespace}.system.xkb;
    i18n = config.${namespace}.system.i18n;
in
{
    options.${namespace}.system.xkb = with types; {
        enable = mkBoolOpt false "Wheter or not to configure xkb";
        layout = mkOpt str "us,no" "Keyboard layout";
    };

    config = mkIf cfg.enable {
        console.useXkbConfig = true;

        services.xserver = {
            xkb = {
                layout = cfg.layout;
                options = "caps:escape";
            };
        };
    };
}