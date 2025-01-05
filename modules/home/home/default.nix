{
    lib,
    osConfig ? { },
    namespace,
    ...
}:
with lib;
with lib.${namespace};
{
    home.stateVersion = mkDefault osConfig.system.stateVersion;
}