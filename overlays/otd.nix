self: super: {
  opentabletdriver = super.opentabletdriver.overrideAttrs (
    old: {
      src = super.fetchFromGitHub {
        owner = "OpenTabletDriver";
        repo = "OpenTabletDriver";
        rev = "43c29035c36bc8536dd8e8e8ccd879ab79ff53ed";
        sha256 = "sha256-VvxW8Ck+XC4nXSUyDhcbGoeSr5uSAZ66jtZNoADuVR8=";
      };
    }
  );
}
