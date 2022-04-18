self: super: { 
    discord-canary = super.discord-canary.overrideAttrs (
        old: { 
            src = builtins.fetchTarball {
                url = "https://discord.com/api/download/canary?platform=linux&format=tar.gz";
                sha256 = "19w1vawayp10f6y1xvdxjrgkky380g1z8yzrlnssdapi08m1bw4l";
            };
        }
    );
}
