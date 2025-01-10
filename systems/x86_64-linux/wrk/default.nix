{
  lib,
  config,
  pkgs,
  namespace,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  homelab = {
    user = {
      name = "torkel";
      fullName = "Torkel Lyng";
      email = "torkel.lyng@gmail.com";
      initialPassword = "password";
      extraGroups = [ "wheel" "networking" ];
    };

    hardware = {
      nvidia = enabled;
      audio = enabled;
      networking = {
        enable = true;
        hostName = "ripper";
      };
    };

    suites = {
      common = enabled;
      common-desktop = enabled;
      development = enabled;
      media = enabled;
    };

    desktop = {
      gnome = disabled;
      hyprland = {
        enable = true;
        # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      };
    };
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.torkel = {
    isNormalUser = true;
    description = "Torkel Lyng";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    	vscode
	    neovim
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	  git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
