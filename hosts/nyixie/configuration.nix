{ config, lib, pkgs, inputs, ... }:

{
  imports = [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    supportedFilesystems = [ "zfs" ];

    zfs.requestEncryptionCredentials = true;
  }; 
  
  services.zfs.autoScrub.enable = true;

  networking = {
    hostName = "suwface";
    hostId = "a7b25734";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      substituters = [
        "https://nix-gaming.cachix.org"
	"https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
	"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
	intel-vaapi-driver
	vaapiVdpau
	libvdpau-va-gl
      ];
    };
  };
  
  # Set your time zone.
   time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
   services.xserver.xkb.layout = "us";

  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = false;
   security.rtkit.enable = true;
   services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
     jack.enable = true;
     lowLatency = {
       enable = true;
       quantum = 64;
       rate = 48000;
       };
   };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  
  users.users.twinz = {
     isNormalUser = true;
     initialPassword = "pw123";
     extraGroups = [ 
     "wheel"
     "networkmanager"
     ];
     shell = pkgs.fish;
     packages = with pkgs; [
       #A
       #B
       #C
       #D
       #E
       #F
       firefox
       fish
       foot
       #G
       #H
       #I
       #J
       #K
       #L
       #M
       #N
       neovim
       #O
       #P
       #Q
       #R
       #S
       #T
       tree
       #U
       #V
       #W
       #X
       #Y
       #Z
       ];
   };

  home-manager = {
  # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
      users = {
        "twinz" = import ./home.nix;
      };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     #A
     auto-cpufreq
     #B
     #C
     curl
     #D
     #E
     #F
     #G
     git
     #H
     #I
     #J
     #K
     #L
     #M
     #N
     niv
     #O
     #P
     #Q
     #R
     #S
     sbctl
     #T
     #U
     #V
     #W
     wget
     #X
     #Y
     #Z
     
   ];
   
   nixpkgs.config.allowUnfree = true;
   
   programs.fish.enable = true;

   services.auto-cpufreq = {
     enable = true;
     settings = {
       battery = {
         governor = "powersave";
         turbo = "never";
       };
       charger = {
         governor = "performance";
         turbo = "never";
         };
     };
   };
  
  # System Upgrade
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  system.stateVersion = "23.11"; # Did you read the comment?

}

