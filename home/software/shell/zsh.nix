{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;

      plugins = [
        "z"
        "git"
      ];

      theme = "";
    };

    initContent = ''
        autoload -U promptinit; promptinit
        zstyle :prompt:pure:environment:nix-shell show no
        prompt pure

        export LC_ALL="en_US.UTF-8"
        export LANG="en_US.UTF-8"
        export LANGUAGE="en_US:en"
    '';
  };

  home.packages = with pkgs; [
    pure-prompt
  ];

  programs.zsh.shellAliases = {
    update = "sudo nixos-rebuild switch --flake .#$(hostname)";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };
}
