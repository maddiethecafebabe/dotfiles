dir=$(dirname "$(readlink -f "$0")")

mkdir -p "$HOME/.config" # just in case

for f in $(ls ./config); do
    echo symlinking $HOME/.config/$f -> $dir/config/$f
    ln -s "$dir/config/$f" $HOME/.config/
done
