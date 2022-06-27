NIXCC := nixos-rebuild switch --use-remote-sudo --flake

host:
	$(NIXCC) . --show-trace

kimono:
	$(NIXCC) .#kimono

yukata:
	$(NIXCC) .#yukata

seifuku:
	$(NIXCC) .#seifuku

ensure-update:
	@nix flake lock --update-input grab-bag

garbage-collect:
	sudo nix-collect-garbage -d
	$(MAKE)

git: ensure-update
	git add .
	git commit
