NIXCC := nixos-rebuild switch --use-remote-sudo --flake

host:
	$(NIXCC) .

kimono:
	$(NIXCC) .#kimono

yukata:
	$(NIXCC) .#yukata

seifuku:
	$(NIXCC) .#seifuku

garbage-collect:
	sudo nix-collect-garbage -d
	$(MAKE)

git:
	git add .
	git commit
