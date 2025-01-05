{
    options,
    config,
    lib,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.apps.slack;
in
{
    options.${namespace}.apps.slack = with types; {
        enable = mkBoolOpt false "Whether or not to enable Slack.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            slack
        ];
    };
}