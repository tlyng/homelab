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
    cfg = config.${namespace}.system.i18n;
in
{
    options.${namespace}.system.i18n = with types; {
        enable = mkBoolOpt false "Wheter or not to manage i18n settings.";
        locale = mkOpt str "en_US.UTF-8" "Locale setting";
        keymap = mkOpt str "us" "Keymap";
    };

    config = mkIf cfg.enable {
        i18n = {
            defaultLocale = cfg.locale;
            supportedLocales = [
                "nb_NO.UTF-8/UTF-8"
            ];
        };

        console = {
            keyMap = mkDefault cfg.keymap;
        };
    };
}