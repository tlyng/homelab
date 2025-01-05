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
    cfg = config.${namespace}.cli-apps.slack;
in
{
    options.${namespace}.cli-apps.slack = with types; {
        enable = mkBoolOpt false "Whether or not to install Slack CLI";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            slack-cli
        ];
    };
}