{
    options,
    lib,
    config,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.apps.brave;
in
{
    options.${namespace}.apps.brave = with types; {
        enable = mkBoolOpt false "Whether or not to enable brave.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            brave
        ];
    };
}