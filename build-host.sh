dir=$(dirname "$(readlink -f "$0")")
homecfgdir="$HOME/.config/nixpkgs"
user=maddie

if [ ! -d $homecfgdir ]; then
    mkdir -p "$HOME/.config" # just in case
    echo symlinking $homecfgdir to $dir/homes/$user
    ln -s $dir/homes/$user $homecfgdir
fi

sudo nixos-rebuild switch --flake .\#$1 --impure

# todo do home-manager initial setup if doesnt exist
# nix-shell '<home-manager>' -A install