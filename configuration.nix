# Edit this configuration file to define what should be 
# installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "nix"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = /home/kieran/keys.map;
    defaultLocale = "en_US.UTF-8";
  };

  # time.timeZone = "Europe/Amsterdam";

  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    ag
    emacs
    firefox
    git
    gnumake
    htop
    stack
    termite
    tmux
    wget
    # xorg.xev
  ];

  services = {

    openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    xserver = {
      enable = true;
      layout = "us";

      desktopManager = {
        gnome3.enable = true;
        default = "gnome3";
      };
    };

  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.kieran = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/kieran";
    description = "Kieran Trezona-le Comte";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
