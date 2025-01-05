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
    cfg = config.${namespace}.cli-apps.spotify-player;
in
{
    options.${namespace}.cli-apps.spotify-player = with types; {
        enable = mkBoolOpt false "Whether or not to enable spotify-player";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            spotify-player
        ];

        homelab.home.extraOptions = {
            programs.spotify-player.enable = true;
            catppuccin.spotify-player.enable = true;
        };
    };
}