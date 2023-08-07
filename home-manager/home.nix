# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # TODO: Set your username
  home = {
    username = "max";
    homeDirectory = "/home/max";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [ xclip ];

  # Shell Configuration
  programs.fish.shellAbbrs = {
    emacs = "emacs --no-splash";
  };
  
  # Enable home-manager 
  programs.home-manager.enable = true;

  # Enable git
  programs.git.enable = true;

  # Enable emacs
  programs.emacs.enable = true;
  programs.emacs.extraPackages = epkgs: [epkgs.nix-mode
                                         epkgs.agda2-mode];
  programs.emacs.extraConfig = 
    ''
      ;; Disable splash screen on startup
      (setq inhibit-startup-screen t)

      ;; Agda packages
      (require 'agda2-mode)
    '';

  # Enable direnv
  programs.direnv.enable = true;
  programs.direnv.enableFishIntegration = true;
  programs.direnv.nix-direnv.enable = true;
  
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
