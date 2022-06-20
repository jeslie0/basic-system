self:
{ config, pkgs, ... }:

{ # imports = [  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jgl";
  home.homeDirectory = "/home/jgl";

  nixpkgs.config.allowUnfree = true;

  # We don't need sway yet.
 # # * Sway

 #  wayland.windowManager.sway = {
 #    enable = true;
 #    wrapperFeatures.gtk = true;
 #  };

  # * Fish
  programs.fish.enable = true;

  # * Emacs
  services.emacs = {
  enable = true;
  package = with pkgs;
    ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  };

  # * Packages
  nixpkgs.overlays = [ (import self.inputs.emacs-overlay) ];

  home.packages = with pkgs; [
    vim
    # firefox

    # mpv
    # imv


    # git
    # git-crypt
    # cryptsetup
    # wget


    isync
    aspell
    aspellDicts.en

    powertop
    pass
    # pavucontrol
    sqlite
    stow

    # texlive.combined.scheme-full
    # zathura

    ripgrep
    direnv
    pandoc

    ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages (epkgs: [ epkgs.vterm ]))


    # swayidle
    # wl-clipboard
    # alacritty
    # dmenu
    # dmenu-wayland
    # bemenu
    # i3status
    starship
    # waybar
    # swaynotificationcenter
    # gammastep
    # wlroots
    # slurp
    # grim
    # self.inputs.passbemenuGitHub.defaultPackage.${system}
    # self.inputs.swaybgchangerGitHub.defaultPackage.${system}
    # self.inputs.bemenuFocusGitHub.defaultPackage.${system}
    # self.inputs.swaylockeffectsGitHub.defaultPackage.${system}
  ];
}
