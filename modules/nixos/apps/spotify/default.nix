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
    cfg = config.${namespace}.apps.spotify;
in
{
    options.${namespace}.apps.spotify = with types; {
        enable = mkBoolOpt false "Whether or not to enable Spotify.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            spotify
        ];
    };
}