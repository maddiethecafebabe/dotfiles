{ home, pkgs, user, ... }:

{
    home = {
        packages = with pkgs; [ rustup ];

        sessionPath = [
            "${user.home}/.cargo/bin"
        ];

        file.".cargo/config.toml".text = with pkgs; ''
        [target.x86_64-unknown-linux-gnu]
        linker = "${clang}/bin/clang"
        rustflags = ["-C", "link-arg=-fuse-ld=${mold}/bin/mold"]
        '';
    };
}
