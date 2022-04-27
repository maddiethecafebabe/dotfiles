{ home, pkgs, user, ... }:

let
    python = pkgs.python3.withPackages (p: with p; [
        pandas
        numpy
        requests
    ]);
in {
    home = {
        packages = [ python ];

        shellAliases = {
            "python" = "python3";
        };

        sessionPath = [
            "${user.home}/.local/bin"
        ];

        sessionVariables = {
            "PYTHONPATH" = "${python}/${python.sitePackages}";
        };
    };
}
