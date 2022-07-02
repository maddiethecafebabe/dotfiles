{lib}: input: let
  inherit (builtins) listToAttrs;
  inherit (lib) imap0 nameValuePair;
  /*
   input = [
       { binding = "<Super>space"; command = "b"; name = "rofi"; }
       { binding = "<Super>x"; command = "a"; name = "xcolor"; }
   ];
   */
in {
  dconf.settings =
    {
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings =
          imap0
          (i: x: "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${toString i}")
          input;
      };
    }
    // listToAttrs (
      imap0 (
        i: v:
          nameValuePair
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${toString i}"
          v
      )
      input
    );
}
