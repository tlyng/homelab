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
    cfg = config.${namespace}.tools.git;
    user = config.${namespace}.user;
in
{
    options.${namespace}.tools.git = with types; {
        enable = mkBoolOpt false "Whether or not to manage git";
        userName = mkOpt str user.fullName "The name to configure git with.";
        userEmail = mkOpt str user.email "The email to configure git with.";
    };

    config = mkIf cfg.enable {
        programs.git = {
            enable = true;
            userName = cfg.userName;
            userEmail = cfg.userEmail;
            lfs = enabled;

            extraConfig = {
                init = {
                    defaultBranch = "main";
                };
                pull = {
                    rebase = true;
                };
                push = {
                    autoSetupRemote = true;
                };
                core = {
                    whitespace = "trailing-space,space-before-tab";
                    pager = "delta";
                };

                interactive = {
                    diffFilter = "delta --color-only";
                };

                delta = {
                    navigate = true;
                    side-by-side = true;
                };

                merge = {
                    conflictstyle = "diff3";
                };

                diff = {
                    colorMoved = "default";
                };
                # safe = {
                #     directory = "${user.home}/work/config/.git";
                # };
            };
        };
    };
}
