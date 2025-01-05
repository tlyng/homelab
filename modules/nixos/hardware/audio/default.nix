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
    cfg = config.${namespace}.hardware.audio;
in
{
    options.${namespace}.hardware.audio = with types; {
        enable = mkBoolOpt false "Whether or not to enable audio support";
        extra-packages = mkOpt (listOf package) [
            pkgs.qjackctl
            pkgs.easyeffects
        ] "Additional packages to install.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            pulsemixer
            pavucontrol
        ]
        ++ cfg.extra-packages;

        hardware.pulseaudio.enable = mkForce false;
        security.rtkit.enable = true;
        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };
    };
}