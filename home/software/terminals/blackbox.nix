{ config, lib, pkgs, ...}:
{
    home.file."snazzy.json" = {
    target = ".local/share/blackbox/schemes/snazzy.json";
    text = ''
      {
          "background-color": "#282a36",
          "badge-color": "#FFFFFF",
          "bold-color": "#FFFFFF",
          "comment": "",
          "cursor-background-color": "#000000",
          "cursor-foreground-color": "#FFFFFF",
          "foreground-color": "#eff0eb",
          "highlight-background-color": "#252734",
          "highlight-foreground-color": "#FAFAFA",
          "name": "Snazzy",
          "palette": [
            "#33303b",
            "#ff5c57",
            "#5af78e",
            "#f3f99d",
            "#57c7ff",
            "#ff6ac1",
            "#9aedfe",
            "#eff0eb",
            "#4f4b58",
            "#ff5c57",
            "#5af78e",
            "#f3f99d",
            "#57c7ff",
            "#ff6ac1",
            "#9aedfe",
            "#eff0eb"
          ],
          "use-badge-color": false,
          "use-bold-color": false,
          "use-cursor-color": false,
          "use-highlight-color": true,
          "use-theme-colors": false
      }
    '';
  };

  dconf.settings = let inherit (lib.hm.gvariant) mkTuple mkUint32 mkVariant; in {
    "com/raggesilver/BlackBox" = {
      context-aware-header-bar = false;
      floating-controls = false;
      font = "Hack Nerd Font Mono 10";
      show-headerbar = true;
      show-scrollbars = false;
      style-preference = (mkUint32 2);
      terminal-padding = (mkTuple [(mkUint32 20) (mkUint32 20) (mkUint32 20) (mkUint32 20)]);
      theme-dark = "Snazzy";
    };
  };
}
