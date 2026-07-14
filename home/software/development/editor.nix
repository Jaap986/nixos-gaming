{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    profiles.default.userSettings = {
      "breadcrumbs.enabled" = false;
      "diffEditor.ignoreTrimWhitespace" = false;
      "diffEditor.renderSideBySide" = false;
      "editor.colorDecorators" = false;
      "editor.copyWithSyntaxHighlighting" = false;
      "editor.detectIndentation" = false;
      "editor.emptySelectionClipboard" = false;
      "editor.fontFamily" = "MonoLisa";
      "editor.fontSize" = 14;
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.gotoLocation.multipleDeclarations" = "goto";
      "editor.gotoLocation.multipleDefinitions" = "goto";
      "editor.gotoLocation.multipleImplementations" = "goto";
      "editor.gotoLocation.multipleReferences" = "goto";
      "editor.gotoLocation.multipleTypeDefinitions" = "goto";
      "editor.guides.indentation" = false;
      "editor.hideCursorInOverviewRuler" = true;
      "editor.hover.enabled" = "off";
      "editor.lightbulb.enabled" = "off";
      "editor.lineHeight" = 0;
      "editor.lineNumbers" = "off";
      "editor.matchBrackets" = "never";
      "editor.minimap.enabled" = false;
      "editor.multiCursorModifier" = "ctrlCmd";
      "editor.occurrencesHighlight" = "off";
      "editor.overviewRulerBorder" = false;
      "editor.renderControlCharacters" = false;
      "editor.renderLineHighlight" = "none";
      "editor.selectionHighlight" = false;
      "editor.snippetSuggestions" = "top";
      "editor.suggestFontSize" = 15;
      "editor.suggestLineHeight" = 28;
      "editor.wordSeparators" = "`~!@#%^&*()=+[{]}\\|;:'\",.<>/?";

      "emmet.includeLanguages" = {
        blade = "html";
        vue = "html";
        "vue-html" = "html";
      };

      "files.associations" = {
        ".php_cs" = "php";
        ".php_cs.dist" = "php";
      };
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      "files.trimTrailingWhitespace" = true;

      "git.autofetch" = true;
      "git.decorations.enabled" = false;

      "php.suggest.basic" = false;
      "problems.decorations.enabled" = false;

      "remote.SSH.remotePlatform" = {
        server = "linux";
      };
      "remote.autoForwardPortsSource" = "hybrid";

      "scm.diffDecorations" = "none";
      "search.exclude" = {
        "**/_ide_helper.php" = true;
        "**/composer.lock" = true;
        "**/dist" = true;
        "**/node_modules" = true;
        "**/package-lock.json" = true;
        "**/public/{[^i],?[^n]}*" = true;
        "**/vendor/{[^l],?[^ai]}*" = true;
        ".phpunit.result.cache" = true;
        storage = true;
      };
      "search.useIgnoreFiles" = false;

      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "terminal.integrated.fontFamily" = "\"Hack Nerd Font\"";
      "terminal.integrated.fontWeight" = "500";
      "update.showReleaseNotes" = false;

      "window.commandCenter" = false;
      "window.menuBarVisibility" = "toggle";
      "window.newWindowDimensions" = "inherit";

      "workbench.colorTheme" = "Snazzy Operator";
      "workbench.editor.enablePreview" = false;
      "workbench.editor.enablePreviewFromQuickOpen" = false;
      "workbench.editor.showTabs" = "single";
      "workbench.iconTheme" = "catppuccin-mocha";
      "workbench.layoutControl.enabled" = false;
      "workbench.startupEditor" = "none";
      "workbench.statusBar.visible" = false;
      "workbench.tips.enabled" = false;

      "[blade]" = {
        "editor.defaultFormatter" = "shufo.vscode-blade-formatter";
      };
      "[jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[php]" = {
        "editor.defaultFormatter" = "junstyle.php-cs-fixer";
      };

      "chat.disableAIFeatures" = true;
      "chat.fontFamily" = "MonoLisa";
      "chatgpt.localeOverride" = "nl-NL";
      "chatgpt.reviewDelivery" = "inline";
    };

    profiles.default.keybindings = [
      {
        key = "ctrl+k ctrl+e";
        command = "workbench.view.explorer";
      }
      {
        key = "ctrl+k ctrl+g";
        command = "workbench.view.scm";
      }
      {
        key = "ctrl+k ctrl+d";
        command = "workbench.view.debug";
      }
      {
        key = "ctrl+k ctrl+x";
        command = "workbench.extensions.action.showEnabledExtensions";
      }
      {
        key = "ctrl+k ctrl+b";
        command = "workbench.action.toggleSidebarVisibility";
      }
      {
        key = "ctrl+e";
        command = "workbench.action.focusActiveEditorGroup";
      }
      {
        key = "ctrl+t";
        command = "workbench.action.terminal.toggleTerminal";
      }
      {
        key = "ctrl+k ctrl+k";
        command = "toggle";
        when = "editorTextFocus";
        args = {
          id = "fontSize";
          value = [
            {
              "editor.fontSize" = 15;
              "editor.lineHeight" = 45;
            }
            {
              "editor.fontSize" = 12;
              "editor.lineHeight" = 0;
            }
          ];
        };
      }
      {
        key = "shift+ctrl+[";
        command = "editor.fold";
        when = "editorFocus";
      }
      {
        key = "shift+ctrl+]";
        command = "editor.unfold";
        when = "editorFocus";
      }
      {
        key = "ctrl+l";
        command = "editor.action.copyLinesDownAction";
        when = "editorTextFocus";
      }
      {
        key = "ctrl+j";
        command = "editor.action.joinLines";
        when = "editorTextFocus";
      }
      {
        key = "ctrl+d";
        command = "duplicate.execute";
        when = "explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !inputFocus";
      }
      {
        key = "ctrl+n";
        command = "explorer.newFile";
        when = "explorerViewletVisible && filesExplorerFocus && !inputFocus";
      }
      {
        key = "shift+ctrl+n";
        command = "explorer.newFolder";
        when = "explorerViewletVisible && filesExplorerFocus && !inputFocus";
      }
      {
        key = "ctrl+backspace";
        command = "editor.action.moveSelectionToPreviousFindMatch";
        when = "editorFocus && editorHasMultipleSelections";
      }
      {
        key = "ctrl+k ctrl+d";
        command = "editor.action.moveSelectionToNextFindMatch";
        when = "editorFocus && editorHasMultipleSelections";
      }
      {
        key = "ctrl+right";
        command = "editor.action.insertCursorAtEndOfEachLineSelected";
        when = "editorFocus && editorHasSelection";
      }
      {
        key = "ctrl+alt+w";
        command = "workbench.action.joinAllGroups";
        when = "editorFocus";
      }
      {
        key = "ctrl+alt+n";
        command = "workbench.action.splitEditor";
        when = "editorFocus";
      }
      {
        key = "ctrl+alt+l";
        command = "workbench.action.navigateRight";
        when = "editorFocus";
      }
      {
        key = "ctrl+alt+h";
        command = "workbench.action.navigateLeft";
        when = "editorFocus";
      }
      {
        key = "ctrl+alt+=";
        command = "workbench.action.increaseViewSize";
        when = "editorFocus";
      }
      {
        key = "ctrl+alt+-";
        command = "workbench.action.decreaseViewSize";
        when = "editorFocus";
      }
      {
        key = "ctrl+alt+n";
        command = "workbench.action.terminal.split";
        when = "terminalFocus";
      }
      {
        key = "ctrl+alt+l";
        command = "workbench.action.terminal.focusNextPane";
        when = "terminalFocus";
      }
      {
        key = "ctrl+alt+h";
        command = "workbench.action.terminal.focusPreviousPane";
        when = "terminalFocus";
      }
      {
        key = "ctrl+alt+w";
        command = "workbench.action.terminal.kill";
        when = "terminalFocus";
      }
      {
        key = "ctrl+m ctrl+i";
        command = "editor.emmet.action.balanceIn";
        when = "editorTextFocus";
      }
      {
        key = "ctrl+m ctrl+o";
        command = "editor.emmet.action.balanceOut";
        when = "editorTextFocus";
      }
      {
        key = "ctrl+m ctrl+w";
        command = "editor.emmet.action.wrapWithAbbreviation";
        when = "editorTextFocus";
      }
      {
        key = "ctrl+m ctrl+m";
        command = "editor.emmet.action.matchTag";
        when = "editorTextFocus";
      }
      {
        key = "ctrl+m ctrl+e";
        command = "editor.action.smartSelect.expand";
        when = "editorTextFocus";
      }
      {
        key = "ctrl+m ctrl+r";
        command = "editor.emmet.action.updateTag";
        when = "editorTextFocus";
      }
      {
        key = "ctrl+m ctrl+backspace";
        command = "editor.emmet.action.removeTag";
        when = "editorTextFocus";
      }
      {
        key = "enter";
        command = "editor.action.nextMatchFindAction";
        when = "findWidgetVisible";
      }
      {
        key = "shift+enter";
        command = "editor.action.previousMatchFindAction";
        when = "findWidgetVisible";
      }
      {
        key = "ctrl+r";
        command = "workbench.action.gotoSymbol";
      }
      {
        key = "ctrl+shift+r";
        command = "workbench.action.showAllSymbols";
      }
      {
        key = "ctrl+k ctrl+enter";
        command = "editor.action.goToDeclaration";
        when = "editorTextFocus";
      }
      {
        key = "ctrl+k ctrl+i";
        command = "namespaceResolver.import";
      }
      {
        key = "ctrl+;";
        command = "workbench.action.switchWindow";
        when = "! config.simple-project-switcher.present";
      }
      {
        key = "alt+ctrl+right";
        command = "workbench.action.showNextWindowTab";
      }
      {
        key = "alt+ctrl+left";
        command = "workbench.action.showPreviousWindowTab";
      }
      {
        key = "alt+ctrl+i";
        command = "workbench.action.toggleDevTools";
      }
      {
        key = "escape";
        command = "notifications.hideToasts";
        when = "notificationToastsVisible";
      }
    ];
  };
}
