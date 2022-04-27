{ home, pkgs, ... }:

let
    deadbeef-discord-rpc = pkgs.fetchzip {
        # i dont wanna bother with building it
        url = "https://github.com/kuba160/ddb_discord_presence/releases/download/v1.4/linux-2edb73b.zip"; 
        sha256 = "sha256-BNsm8ta2TK6Wo5gmTRibPGUgIYm40AQDQPrSLO7vR5s=";
    };
in {
    home.packages = [ pkgs.deadbeef ];

    home.file.".local/lib/deadbeef/discord_presence.so".source = "${deadbeef-discord-rpc.outPath}/discord_presence.so";
}
