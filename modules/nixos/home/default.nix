{
    options,
    config,
    pkgs,
    lib,
    namespace,
    inputs,
    ...
}:
with lib;
with lib.${namespace};
let
    system = "x86_64-linux";
    cfg = config.${namespace}.home;
    extraSpecialArgs = {
        inherit system;
        inherit inputs;
    };
in
{
    options.${namespace}.home = with types; {
        file = mkOpt attrs { } (
            mdDoc "A set of files to be managed by home-manager's `home.file`."
        );
        configFile = mkOpt attrs { } (
            mdDoc "A set of files to be managed by home-manager's `xdg.confgFile`."
        );
        extraOptions = mkOpt attrs { } (
            mdDoc "Options to pass directly to home-manager."
        );
    };

    config = {
        homelab.home.extraOptions = {
            imports = with inputs; [ catppuccin.homeManagerModules.catppuccin ];
            home.stateVersion = config.system.stateVersion;
            home.file = mkAliasDefinitions options.${namespace}.home.file;
            xdg.enable = true;
            xdg.configFile = mkAliasDefinitions options.${namespace}.home.configFile;
        };

        home-manager = {
            inherit extraSpecialArgs;
            useUserPackages = true;
            useGlobalPkgs = true;

            users.${config.${namespace}.user.name} =
                mkAliasDefinitions options.${namespace}.home.extraOptions;
        };
    };
}