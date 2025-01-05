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
    cfg = config.${namespace}.cli-apps.delta;
in
{
    options.${namespace}.cli-apps.delta = with types; {
        enable = mkBoolOpt false "Whether or not to enable delta";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            delta
        ];

        # homelab.home.extraOptions = {
        #     programs.delta = {
        #         enable = true;
        #     };
        # };
    };
}