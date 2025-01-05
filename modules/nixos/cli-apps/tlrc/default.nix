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
    cfg = config.${namespace}.cli-apps.tlrc;
in
{
    options.${namespace}.cli-apps.tlrc = with types; {
        enable = mkBoolOpt false "Whether or not to enable tlrc";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            tlrc
        ];
    };
}