{
    options,
    config,
    lib,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace}; let
    cfg = config.${namespace}.suites.development;
in
{
    options.${namespace}.suites.development = with types; {
        enable = mkBoolOpt false "Whether or not to enable development configuration.";
    };

    config = mkIf cfg.enable {
        
        homelab = {
            tools = {
                comma = enabled;
                kubernetes = enabled;
            };

            cli-apps = {
                k9s = enabled;
                lazygit = enabled;
            };

            virtualisation = {
                kvm = enabled;
                podman = enabled;
            };
        };
    };
}