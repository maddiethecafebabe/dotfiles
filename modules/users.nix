{ ... }: 

let initial_password = "smashthestate";
    ssh_keys = [ 
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtcvLuQkjb0ysly3pbisPn9EBopXhHWIxV3kY1wTeQBokOAejiGnwZu5hGdID+2OOgPSQa5gjq2M02ZAdFx6fq58N9bjW1IkKpPGXjzBs1YkugBVkKtz/gJlv78t6gHweCmaC26zTM/WH5Muo6OrbiBaUbeQWkLs0MLQkMIvsDIF/9k/qYaJb+w6XuHwoOtF8DQVto6bADJlqcNHzEbvIlrYJ7ZbhQimbnK6JD8wVUYDEmM+XWYHA448wjf4zikkgYmhQi4XFNvDdmpQNqNtEH0BOta8FEOxogcjKlS9MQOTAvVo6gaz/MziirMQvWMp8piinoeDrYXUjRNb6cJY0wHo7CA8yeP43D/q90hIsNTOvKi45x6o7G3/4gxmLADxYjLG0DNT6PDmBVGRJ87Etc0sJtsYXfJVW9XWS9UdWldOL7ZLSuUVNAKoFJJ9fh9LVkxwJOHPQsHSQJxmtE8otYOq/LCLNtJT/3lUtAfmaBpQseeLTMPKY2tp0hQ7PJT+/mUEzjSYntjkTyhZJoU2paxwBXu9hDn95NriIjBIUkuj4CeGvpG5gDkbrQPjQON8uq5nlSAJgvhKsPk6fKGpRZEnJj+KYCTvVDIeXpoSSslgVGgdgTeXb1t8vL+Sng/+SgvAP2BBfPXtjCkEyi1L19iez+s6KTp6mRhNYZBV7bkQ== maddie@kimono"
 ];
in {
    users = {
      mutableUsers = true;
      users."maddie" = {
          uid = 1001;
          description = "Madeline";
          isNormalUser = true;
          initialPassword = initial_password;
          extraGroups = [ "wheel" ];
          openssh.authorizedKeys.keys = ssh_keys;
        };
      };
    
}
