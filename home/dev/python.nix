{ home, pkgs, user, ... }:

let
    python3 = pkgs.python3.withPackages (p: with p; [
        pandas
        numpy
        requests
    ]);
in {
    home = {
        packages = [ python3 ];

        shellAliases = {
            "python" = "python3";
        };

        sessionPath = [
            "${user.home}/.local/bin"
        ];

        sessionVariables = {
            "PYTHONPATH" = "${python3}/${python3.sitePackages}";
        };
    };
}
