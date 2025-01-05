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
    cfg = config.${namespace}.desktop.gnome;
    gdmHome = config.users.users.gdm.home;

    defaultExtensions = with pkgs.gnomeExtensions; [
        appindicator
        # aylurs-widgets
        dash-to-dock
        gsconnect
        gtile
        just-perfection
        logo-menu
        no-overview
        # remove-app-menu
        space-bar
        top-bar-organizer
        wireless-hid
    ];

    default-attrs = mapAttrs (key: mkDefault);
    nested-default-attrs = mapAttrs (key: default-attrs);
in
{
    options.${namespace}.desktop.gnome = with types; {
        enable = mkBoolOpt false "Whether or not to use Gnome as the desktop environment.";
        wayland = mkBoolOpt true "Whether or not to use Wayland.";
        suspend = mkBoolOpt true "Whether or not to suspend the machine after inactivity.";
        extensions = mkOpt (listOf package) [ ] "Extra Gnome extensions to install.";
    };

    config = mkIf cfg.enable {
        homelab.system.xkb.enable = true;
        homelab.desktop.addons = {
            gtk = enabled;
            electron-support = enabled;
            foot = enabled;
        };

        environment.systemPackages = with pkgs; [
            wl-clipboard
            gnome-tweaks
            gnome-extension-manager
            nautilus
            nautilus-python
        ]
        ++ defaultExtensions
        ++ cfg.extensions;

        environment.gnome.excludePackages = with pkgs; [
            gnome-tour
            epiphany
            geary
            gnome-font-viewer
            gnome-system-monitor
            gnome-maps
        ];

        # Required for app indicators
        services.udev.packages = with pkgs; [ gnome-settings-daemon ];
        
        services.libinput.enable = true;
        services.gvfs.enable = true;
        services.xserver = {
            enable = true;

            displayManager.gdm = {
                enable = true;
                wayland = cfg.wayland;
                autoSuspend = cfg.suspend;
            };
            desktopManager.gnome.enable = true;
        };

        programs.kdeconnect = {
            enable = true;
            package = pkgs.gnomeExtensions.gsconnect;
        };
    };
}