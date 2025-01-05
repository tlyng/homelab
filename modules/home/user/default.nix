{
    lib,
    config,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.user;

    home-directory = 
        if cfg.name == null then
            null
        else if pkgs.stdenv.isLinux then
            "/home/${cfg.name}"
        else if pkgs.stdenv.isDarwin then
            "/Users/${cfg.name}"
        else
            null;
in
{
    options.${namespace}.user = with types; {
        enable = mkBoolOpt true "Whether to configure the user account.";
        name = mkOpt (nullOr str) "guest" "The user account.";

        fullName = mkOpt str "Guest Account" "The full name of the user.";
        email = mkOpt str "guest@account.com" "The email of the user.";

        home = mkOpt (nullOr str) home-directory "The user's home directory.";
    };

    config = mkIf cfg.enable (mkMerge [
        {
            assertions = [
                {
                    assertion = cfg.name != null;
                    message = "homelab.user.name must be set";
                }
                {
                    assertion = cfg.home != null;
                    message = "homelab.user.home must be set";
                }
            ];

            home = {
                username = mkDefault cfg.name;
                homeDirectory = mkDefault cfg.home;
            };
        }
    ]);
}