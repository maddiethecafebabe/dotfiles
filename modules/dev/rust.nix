{ lib, pkgs, config, ... }:
with lib;
let
    cfg = config.modules.dev;
in {
    config = mkIf cfg.enable {
        user.home = {
            packages = with pkgs; [ rustup ];

            sessionPath = [
                "${config.user.homeDir}/.cargo/bin"
            ];

            # since rust is a language where projects can easily go into the 
            # triple digits of dependencies linking takes quite a while and makes out
            # most of rebuilds. 
            # this sets it to use the mold linker (https://github.com/rui314/mold)
            # which is a lot faster than the alternatives
            file.".cargo/config.toml".text = with pkgs; ''
            [target.x86_64-unknown-linux-gnu]
            linker = "${clang}/bin/clang"
            rustflags = ["-C", "link-arg=-fuse-ld=${mold}/bin/mold"]
            '';
        };
    };
}
