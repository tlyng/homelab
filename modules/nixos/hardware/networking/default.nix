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
    cfg = config.${namespace}.hardware.networking;
in
{
    options.${namespace}.hardware.networking = with types; {
        enable = mkBoolOpt false "Wheter or not to enable networking support";
        hostName = mkOpt str "hostname" "The hostname for this system.";
        hosts = mkOpt attrs { } (
            mdDoc "An attribute set to merge with `networking.hosts`"
        );
    };

    config = mkIf cfg.enable {
        homelab.user.extraGroups = [ "networkmanager" ];

        networking = {
            hostName = cfg.hostName;
            networkmanager.enable = true;

            hosts = {
                "127.0.0.1" = [ "local.test" ] ++ (cfg.hosts."127.0.0.1" or [ ]);
            } // cfg.hosts;
        };
    };
}