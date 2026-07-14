{ ...}:
{
  programs.zsh.shellAliases = {
    g = "git";
    ga = "git add";
    gcm = "git commit -sm";
    gp = "git push";
    gpl = "git pull";
    gr = "git rebase";
    gs = "git status";
  };

  programs.gh = {
    enable = true;
    settings = {
      version = "1";
      git_protocol = "ssh";
    };
  };

  programs.git = {
    enable = true;
  };
}
