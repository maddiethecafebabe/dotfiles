# seifuku
seifuku is my raspi4, mostly used as a samba/sshfs share and for running
certain small things like web scrapers

hint: nixos takes quite a bit of space, so your sd card should be *at the very least* 16GiB big and even then, expect to constantly be at less than 2gb free space. 
if you want a smaller pi distro use minimal raspbian or ubuntu server

# installation
1. pick a somewhat up to date image from [here](https://hydra.nixos.org/job/nixos/trunk-combined/nixos.sd_image.aarch64-linux)
2. `unzstd -d <path/to/iso>` 
3. flash it to your favourite sd (e.g. `sudo dd if=path/to/iso of=/dev/<sd> conv=fsync status=progress bs=4096`)
4. put sd into your pi and boot
5. read [this](https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi)
6. nixos-install --flake seems to be broken on raspi atleast, so use a temp system for boootstrapping: 
    ```sh
    curl -L https://tinyurl.com/nixos-rpi4-tutorial | sudo tee /etc/nixos/configuration.nix
    sudo nixos-install --root /
    ```
7. on the next boot, proceed with the root readme's step 2
