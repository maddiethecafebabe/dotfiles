NIXCC := nixos-rebuild switch --use-remote-sudo --flake

host:
	$(NIXCC) .

kimono:
	$(NIXCC) .#kimono

yukata:
	$(NIXCC) .#yukata

seifuku:
	$(NIXCC) .#seifuku

git:
	git add .
	git commit
	git push
