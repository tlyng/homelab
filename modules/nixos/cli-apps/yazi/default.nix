{
    config,
    lib,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.cli-apps.yazi;
in
{
    options.${namespace}.cli-apps.yazi = with types; {
        enable = mkBoolOpt false "Whether or not to install Yazi.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            ffmpeg
            p7zip
            jq
            poppler
            fd
            xclip
            wl-clipboard
            xsel
        ];

        homelab.cli-apps = {
            ripgrep = enabled;
            zoxide = enabled;
        };

        homelab.home.extraOptions = {
            programs.yazi.enable = true;
            catppuccin.yazi.enable = true;
        };
    };
}