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
    cfg = config.${namespace}.system.fonts;
in
{
    options.${namespace}.system.fonts = with types; {
        enable = mkBoolOpt false "Wheter or not to manage fonts.";
        fonts = mkOpt (listOf package) [] "Custom font packages to install.";
    }; 

    config = mkIf cfg.enable {
        environment.variables = {
            # Enable icons in tooling since we have nerdfonts.
            LOG_ICONS = "true";
        };

        environment.systemPackages = with pkgs; [ font-manager ];

        fonts.fontconfig.enable = true;
    
        fonts.packages = with pkgs; [
            font-awesome
            nerdfonts
        ]
        ++ cfg.fonts;
    };
}