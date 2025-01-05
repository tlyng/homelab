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
    cfg = config.${namespace}.hardware.nvidia;
in
{
    options.${namespace}.hardware.nvidia = with types; {
        enable = mkBoolOpt false "Whether or not to enable nvidia support";
    };

    config = mkIf cfg.enable {
        hardware.graphics.enable = true;
        services.xserver.videoDrivers = ["nvidia"];
        hardware.nvidia = {
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = true;
        };
    };
}