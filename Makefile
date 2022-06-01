NIXCC := nixos-rebuild switch --use-remote-sudo --flake

host: assure_grab_bag_up_to_date
	$(NIXCC) .

kimono: assure_grab_bag_up_to_date
	$(NIXCC) .#kimono

yukata: assure_grab_bag_up_to_date
	$(NIXCC) .#yukata

seifuku: assure_grab_bag_up_to_date
	$(NIXCC) .#seifuku

assure_grab_bag_up_to_date:
	@nix flake lock --update-input grab-bag

garbage-collect:
	sudo nix-collect-garbage -d
	$(MAKE)

git: assure_grab_bag_up_to_date
	git add .
	git commit
