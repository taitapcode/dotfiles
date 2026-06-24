{ config, lib, ... }:

let
  cfg = config.modules.home.program.fcitx5;
in
{
  options.modules.home.program.fcitx5.enable = lib.mkEnableOption "Enable Fcitx5 configuration";

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      GTK_IM_MODULE = "fcitx5";
      QT_IM_MODULE = "fcitx5";
      XMODIFIERS = "@im=fcitx5";
    };

    xdg.configFile."fcitx5/config".text = ''
      [Hotkey]
      EnumerateWithTriggerKeys=True
      EnumerateSkipFirst=False
      ModifierOnlyKeyTimeout=250

      [Hotkey/TriggerKeys]
      0=Alt+Z
      1=Zenkaku_Hankaku
      2=Hangul

      [Hotkey/ActivateKeys]
      0=Hangul_Hanja

      [Hotkey/DeactivateKeys]
      0=Hangul_Romaja

      [Hotkey/AltTriggerKeys]
      0=Shift_L

      [Hotkey/EnumerateGroupForwardKeys]
      0=Super+space

      [Hotkey/EnumerateGroupBackwardKeys]
      0=Shift+Super+space

      [Hotkey/PrevPage]
      0=Up

      [Hotkey/NextPage]
      0=Down

      [Hotkey/PrevCandidate]
      0=Shift+Tab

      [Hotkey/NextCandidate]
      0=Tab

      [Hotkey/TogglePreedit]
      0=Control+Alt+P

      [Behavior]
      ActiveByDefault=False
      resetStateWhenFocusIn=No
      ShareInputState=No
      PreeditEnabledByDefault=True
      ShowInputMethodInformation=True
      showInputMethodInformationWhenFocusIn=False
      CompactInputMethodInformation=True
      ShowFirstInputMethodInformation=True
      DefaultPageSize=5
      OverrideXkbOption=False
      PreloadInputMethod=True
      AllowInputMethodForPassword=False
      ShowPreeditForPassword=False
      AutoSavePeriod=30
    '';

    xdg.configFile."fcitx5/profile".text = ''
      [Groups/0]
      Name=Default
      Default Layout=us
      DefaultIM=lotus

      [Groups/0/Items/0]
      Name=keyboard-us

      [Groups/0/Items/1]
      Name=lotus

      [GroupOrder]
      0=Default
    '';
  };
}
