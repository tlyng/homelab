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
            name = "guest";
        };

        tools = {
            git = enabled;
        };
    };
}
