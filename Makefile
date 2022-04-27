NIXCC := nixos-rebuild switch --impure --use-remote-sudo --flake

host:
	$(NIXCC) .

kimono:
	$(NIXCC) .#kimono

yukata:
	$(NIXCC) .#yukata

seifuku:
	$(NIXCC) .#seifuku
