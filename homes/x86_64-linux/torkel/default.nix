{
    lib,
    pkgs,
    config,
    namespace,
    ...
}:
with lib.${namespace};
{
    homelab = {
        user = {
            enable = true;
            name = "torkel";
            fullName = "Torkel Lyng";
            email = "torkel.lyng@gmail.com";
        };

        tools = {
            git = enabled;
        };
    };
}
