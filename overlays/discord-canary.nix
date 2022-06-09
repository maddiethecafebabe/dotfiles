# discord-canary gets updated often and some updates ignore the SKIP_HOST_UPDATE setting..
# TODO: the sha256 argument is optional and may be more convenient being left out? not sure 
# how often nix will try to refetch it tbh, that may be something to look into

self: super: { 
    discord-canary = (super.discord-canary.overrideAttrs (
        old: { 
            src = builtins.fetchTarball {
                url = "https://discord.com/api/download/canary?platform=linux&format=tar.gz";
                sha256 = "19w1vawayp10f6y1xvdxjrgkky380g1z8yzrlnssdapi08m1bw4l";
            };
        }
    ));
}
