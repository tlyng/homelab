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
    cfg = config.${namespace}.tools.kubernetes;
    defaultPackages = with pkgs; [
        kubectl
        kubecolor
        skaffold
        kind
        kubernetes-helm
        kustomize
        kubectx
        fluxcd
        kyverno
    ];
in
{
    options.${namespace}.tools.kubernetes = with types; {
        enable = mkBoolOpt false "Whether or not to install Kubernetes tools";
        extraPackages = mkOpt (listOf package) [ ] "Additional packages to install.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = defaultPackages
        ++ cfg.extraPackages;
    };
}