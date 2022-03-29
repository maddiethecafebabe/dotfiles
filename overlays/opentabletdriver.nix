# use a fork with my Artist 15.6 config until
# support for it lands upstream

self: super: {
  opentabletdriver = super.opentabletdriver.overrideAttrs (
    old: {
      src = super.fetchFromGitHub {
        owner = "maddiethecafebabe";
        repo = "OpenTabletDriver";
        rev = "b100761c5b6680bf252e9e33a5f89b7f911a557b";
        sha256 = "sha256-H1C+UAAT1PgKDaAZWI3quf6Mpj9aY7EwWXr0VPuZFhU=";
      };
    }
  );
}
