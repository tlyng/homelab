{
    lib,
    config,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace}; let
    cfg = config.${namespace}.system.boot.efi;
in {
    options.${namespace}.system.boot.efi = with types; {
        enable = mkBoolOpt false "Wheter or not to enable booting.";
    };

    config = mkIf cfg.enable {
        boot.loader.systemd-boot.enable = true;
        boot.loader.systemd-boot.configurationLimit = 10;
        boot.loader.systemd-boot.editor = false;
        boot.loader.efi.canTouchEfiVariables = true;
    };
}