{ config, pkgs, lib, inputs, ... }:
let
  betterfox = inputs.betterfox;
  firefoxProfilePath = "default";
in
{
  # Firefox GNOME theme
  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/${firefoxProfilePath}/chrome/firefox-gnome-theme";
    source = inputs.firefox-gnome-theme;
  };
  home.file.".mozilla/firefox/profiles.ini".force = true;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    configPath = ".mozilla/firefox";

    profiles.default = {
      name = "Default";
      path = firefoxProfilePath;
      id = 0;
      isDefault = true;

      settings = {
        # --- UI & Appearance ---
        "browser.tabs.drawInTitlebar" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "extensions.activeThemeID" = "default-theme@mozilla.org";
        "svg.context-properties.content.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # --- General Behavior ---
        "browser.newtabpage.enabled" = false;
        "browser.policies.runOncePerModification.setDefaultSearchEngine" = "Qwant";
        "browser.startup.page" = 0;
        "intl.locale.requested" = "nl";

        # --- Security & Networking ---
        "dom.security.https_only_mode" = true;
      };

      # Import Betterfox user.js
      extraConfig = builtins.concatStringsSep "\n" [
        (builtins.readFile "${betterfox}/user.js")
      ];

      # Gnome-theme integration
      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";

        /* Use system icons for privacy/security category */
        toolbarbutton[id*="78272b6fa58f4a1abaac99321d503a20"] .toolbarbutton-icon {
          list-style-image: url(chrome://browser/skin/preferences/category-privacy-security.svg) !important;
        }
        /* Hide badges for specific extension */
        toolbarbutton[id*="78272b6fa58f4a1abaac99321d503a20"] .toolbarbutton-badge {
          display:none !important;
        }
      '';
    };

    languagePacks = [ "en-US" "nl" ];

    policies = {
      # --- General Settings ---
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;
      DisableAutocompleteControls = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableFirefoxStudies = true;
      DisableForgetButton = true;
      DisableFormHistory = true;
      DisableMasterPasswordCreation = true;
      DisablePasswordReveal = true;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      DisplayMenuBar = "default-off";
      DontCheckDefaultBrowser = true;
      ExtensionUpdate = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      RequestedLocales = [ "nl" ];

      # --- Privacy & Security ---
      DNSOverHTTPS = {
        Enabled = false;
        Locked = true;
      };
      EnableTrackingProtection = {
        Cryptomining = true;
        EmailTracking = true;
        Fingerprinting = true;
        Locked = true;
        Value = true;
      };
      EncryptedMediaExtensions = {
        Enabled = true;
        Locked = true;
      };
      HttpsOnlyMode = "force_enabled";
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
        Downloads = true;
        FormData = true;
        History = true;
        Locked = true;
        OfflineApps = true;
        Sessions = true;
        SiteSettings = false;
      };

      # --- Homepage & New Tab ---
      FirefoxHome = {
        Highlights = false;
        Locked = true;
        Pocket = false;
        Search = true;
        Snippets = false;
        SponsoredPocket = false;
        SponsoredTopSites = false;
        TopSites = false;
      };
      FirefoxSuggest = {
        ImproveSuggest = false;
        Locked = true;
        SponsoredSuggestions = false;
        WebSuggestions = false;
      };
      Homepage = {
        StartPage = "none";
        URL = "about:blank";
      };
      NewTabPage = { Enabled = false; };

      # --- Search Engines ---
      SearchEngines = {
        Default = "Qwant";
        DefaultPrivate = "Qwant";
        PreventInstalls = true;
        Remove = [ "Amazon.com" "Bing" "Google" ];
      };

      # --- PDF Handling ---
      DisableBuiltinPDFViewer = true;
      Handlers = { mimeTypes."application/pdf".action = "saveToDisk"; };
      PDFjs = {
        Enabled = false;
        EnablePermissions = false;
      };
      extensions.pdf = {
        action = "useHelperApp";
        ask = true;
        handlers = [{
          name = "GNOME Document Viewer";
          path = "${pkgs.evince}/bin/evince";
        }];
      };

      # --- Extension Management ---
      ExtensionSettings = with builtins;
        let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        in listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
        ];

      "3rdparty".Extensions = {
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = rec { cloudStorageEnabled = lib.mkForce false; };
          selectedFilterLists = [
            "NLD-0"
            "easylist"
            "easyprivacy"
            "adguard-social"
            "plowe-0"
            "ublock-annoyances"
            "ublock-badware"
            "ublock-cookies-adguard"
            "ublock-filters"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "urlhaus-1"
            "user-filters"
          ];
        };
      };
    };
  };
}
