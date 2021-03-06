# original keys, do not steal!!
rec {
  kimono = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICC8gQF2UzYxgkK/QhmZN/ARfdYOkaJ10AuyoiyH+Vfr maddie@kimono-2022-06-02"];
  seifuku = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG7R+ICMNoyiYtDHpb1CdC1BLgjwgAKQe4mtNePN7oVt maddie@seifuku-2022-06-02"];
  yukata = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJGEsncvD0ziYspiKy7lupfghDf96zye8qqM/nnpHBN9 maddie@yukata-2022-06-02"];

  # this uses security.pki.certificateFiles instead of certificates because the latter
  # just doesnt seem to have an effect..
  rootCAFiles = [
    ./gensokyoCA.pem
  ];

  workstations = kimono ++ yukata;
  servers = seifuku;
}
