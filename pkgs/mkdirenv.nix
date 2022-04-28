# taken from https://github.com/InfinityGhost/nixos-workstation/blob/master/pkgs/nix-direnv-init/default.nix

{ lib
, writers
, symlinkJoin
}:

let
  pname = "mkdirenv";
  bin = writers.writeBashBin pname ''
    function check-file
    {
      if [ -e "$1" ]; then
        echo "Aborting: The file '$1' already exists."
        exit 1;
      fi
    }
    check-file "shell.nix"
    # check-file ".envrc"
    echo "Creating nix direnv files..."
    cat > shell.nix <<EOF
    { pkgs ? import <nixpkgs> { } }:
    
    pkgs.mkShell {
      nativeBuildInputs = with pkgs; [ ];
      buildInputs = with pkgs; [ ];
      inputsFrom = with pkgs; [ ];
      hardeningDisable = [ "all" ];
      shellHook = "";
    }

    EOF
    $EDITOR shell.nix
    cat > .envrc <<EOF
    use nix
    
    EOF
    direnv allow
  '';
in symlinkJoin {
  name = pname;
  paths = [ bin ];
}
