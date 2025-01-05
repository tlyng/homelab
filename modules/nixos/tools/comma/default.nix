{
    options,
    config,
    lib,
    pkgs,
    namespace,
    inputs,
    ...
}:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.tools.comma;
in
{
    imports = with inputs; [
        nix-index-database.nixosModules.nix-index
    ];

    options.${namespace}.tools.comma = with types; {
        enable = mkBoolOpt false "Whether or not to enable comma.";
    };

    config = mkIf cfg.enable {
        programs.nix-index-database.comma.enable = true;
    };
}