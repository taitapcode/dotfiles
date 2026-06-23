{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.home.zen-browser;
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  options.modules.home.zen-browser.enable = lib.mkEnableOption "Enable Zen Browser Configuration";

  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = false;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };

      profiles.default = {
        mods = [
          "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find Bar
          "f7c71d9a-bce2-420f-ae44-a64bd92975ab" # Better Unloaded Tabs
          # "72f8f48d-86b9-4487-acea-eb4977b18f21" # Better CtrlTab Panel
          "d8b79d4a-6cba-4495-9ff6-d6d30b0e94fe" # Better Active Tab
          "664c54f9-d97d-410b-a479-23dd8a08a628" # Better Tab Indicators
          "4ab93b88-151c-451b-a1b7-a1e0e28fa7f8" # No Sidebar Scrollbar
          "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
          "58649066-2b6f-4a5b-af6d-c3d21d16fc00" # Private Mode Highlighting
          "8039de3b-72e1-41ea-83b3-5077cf0f98d1" # Trackpad Animation
          "599a1599-e6ab-4749-ab22-de533860de2c" # Pimp your PiP
        ];

        keyboardShortcuts = [
          {
            id = "zen-workspace-backward";
            key = "q";
            modifiers = {
              alt = true;
            };
          }
          {
            id = "zen-workspace-forward";
            key = "w";
            modifiers = {
              alt = true;
            };
          }
        ];

        containersForce = true;
        containers = {
          Personal = {
            color = "purple";
            icon = "fingerprint";
            id = 1;
          };
          Study = {
            color = "blue";
            icon = "briefcase";
            id = 2;
          };
        };

        spacesForce = true;
        spaces = {
          "Daily" = {
            id = "c6de089c-410d-4206-961d-ab11f988d40a";
            position = 1000;
            icon = "💻";
            container = 1;
          };
          "Study" = {
            id = "cdd10fab-4fc5-494b-9041-325e5759195b";
            position = 2000;
            icon = "📚";
            container = 2;
          };
        };

        pinsForce = true;
        pinsForceAction = "remove";
        pins = {
          "GitHub" = {
            id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
            url = "https://github.com";
            position = 101;
            isEssential = true;
            container = 1;
          };
          "Gmail" = {
            id = "40ca2d05-a429-4539-b8d9-2ae477c021a5";
            url = "https://mail.google.com/mail/u/0/#inbox";
            position = 102;
            isEssential = true;
            container = 1;
          };
          "Drive" = {
            id = "f0b6401d-40b6-4f05-9eba-b07ce03eb938";
            url = "https://drive.google.com/drive/my-drive";
            position = 103;
            isEssential = true;
            container = 1;
          };
          "Youtube" = {
            id = "4e3b255e-9c63-42a9-bf31-f5cc98a01450";
            url = "https://www.youtube.com/";
            position = 104;
            isEssential = true;
            container = 1;
          };
          "Gemini" = {
            id = "1cd614cf-cb2a-4e9d-97ba-b42be17ca761";
            url = "https://gemini.google.com/app";
            position = 105;
            isEssential = true;
            container = 1;
          };
          "Claude" = {
            id = "f41edcd1-b367-409f-ad80-506924daf97e";
            url = "https://claude.ai/";
            position = 106;
            isEssential = true;
            container = 1;
          };
          "Youtube Music" = {
            id = "55b18b31-65f5-4ade-ac44-cf54a3ddf325";
            url = "https://music.youtube.com/";
            position = 107;
            isEssential = true;
            container = 1;
          };
          "Facebook" = {
            id = "3757ac88-55f5-4466-8111-18b6458cde11";
            url = "https://facebook.com";
            position = 108;
            isEssential = true;
            container = 1;
          };
          "Nix options" = {
            id = "73b6be11-a5c9-4e17-8ab7-58a84e4afd58";
            url = "https://search.nixos.org/options";
            position = 109;
            isEssential = true;
            container = 1;
          };

          "MyBK" = {
            id = "5af8ecd0-55f0-4084-96f5-eb4bc62a5d4e";
            url = "https://mybk.hcmut.edu.vn/my/index.action";
            position = 101;
            isEssential = true;
            container = 2;
          };
          "BK Drive" = {
            id = "ab7d2102-3877-46c1-b8fc-582080ef90b2";
            url = "https://drive.google.com/drive/my-drive";
            position = 102;
            isEssential = true;
            container = 2;
          };
        };
      };
    };
  };
}
