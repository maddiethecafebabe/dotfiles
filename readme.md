# super average dotfiles
theyre not special, but theyre mine

# installation
1. look at ./hosts/$HOST/readme.md for specific steps for the respective host
2. clone this repository to the machine
3. run nix-shell
4. run ./build-host.sh
5. change password
6. debug the issues you are probably getting now

# fresh system
installation on a fresh system is almost the same, 
but you should do 
```sh
nixos-install --impure --root /mnt --flake .#<host>
```
instead for the first time, then after a reboot logged in as the non-root user it wont hurt
doing a `./build-host.sh` so symlinks for config get created, though that is more or less
optional
