{ config, pkgs, ... }:
{
  home.username = "davidmij";
  home.homedirectory = "/home/davidmij";

  home.stateversion = "23.11"; # please read the comment before changing.

  home.packages = with pkgs; [
    jaq
    gnome.networkmanager-openconnect
    gnome.gnome-sound-recorder
    xclip
    openssh
    libreoffice
    just
    git
    yq
    slack
    pulseaudio
    #zoom-us --- is not working, dont forget to install using apt\snap
    jetbrains-toolbox
    google-chrome
    kubectl
    unixtools.nettools
    discord
    kubectx
    vscodium
    steam
    gnome.nautilus
    tldr
    sops
    (google-cloud-sdk.withextracomponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    openconnect
    (nerdfonts.override {fonts = ["firacode"];})
    haskellpackages.greenclip
  ];

  home.pointercursor = {
      package = pkgs.bibata-cursors;
      name = "bibata-modern-ice";
      size = 22;
    };
  programs = {
    bash.enable = true;
    direnv = {
    enable = true;
    config.whitelist.prefix = ["~/walmart"];
    nix-direnv.enable = true;
      };

  rofi = {
      enable = true;
      theme = "arc-dark";
      font = "fira code 14";
      extraconfig = {
         modes = "clipboard:greenclip print";
         ssh-command = "{terminal} {ssh-client} {host} [-p {port}]";
      };
};
  fzf.enable = true;
  k9s.enable = true;

    neovim = {
      enable = true;
      vialias = true;
      vimalias = true;
      vimdiffalias = true;      
    };
    starship.enable = true;
    eza = {
    enable = true;
    enablealiases = true;
    icons = true;
    git = true;
    };

  };
  # if the config file for the relevant app is not at ~/.config/<configfile> so i need to configure this
  #xdg.configfile = {
  #  "starship.toml".source = ./starship.toml;
  #};
  home.shellaliases = {
  prime-run= "__nv_prime_render_offload=1 __vk_layer_nv_optimus=nvidia_only __glx_vendor_library_name=nvidia";
  k = "${pkgs.kubectl}/bin/kubectl";
  p = "https_proxy=socks5://localhost:8888";
  };
  home.sessionvariables = {
    editor = "nvim";
  };
  
  services.flameshot.enable = true;

  # let home manager install and manage itself.
  programs.home-manager.enable = true;
  targets.genericlinux.enable = true;
  fonts.fontconfig.enable = true;
    home.activation = {
  #  linkdesktopapplications = {
  #    after = [ "writeboundary" "createxdguserdirectories" ];
  #    before = [ ];
  #    data = "/usr/bin/update-desktop-database";
  #  };
  };
  systemd.user.services.greenclip = {
      unit = {
        description = "greenclip daemon";
        startlimitintervalsec = 0;
      };
      install = {
        wantedby = ["default.target"];
      };
      service = {
        execstart = "${pkgs.haskellpackages.greenclip}/bin/greenclip daemon";
        restart = "always";
      };
    };
}
