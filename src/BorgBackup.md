# BorgBackup

### points to write about
- [ ] borg backup cannot backup to a repo that is currently mounted (e.g. fuse mount to get files from an old backup)
- [ ] nix borgbackup service, and point out the doInit function.
- [ ] notes on the append only key on borgbase and the drawbacks of borg serverside pruning. (timed attack can delete all backups)
- [ ] keyfiles and how to use them with borgbackup, and that all keys have a passphrase, that may be null.


### stuff learn about
- [ ] secrets management with nix.
- [ ] secrets management with podman. (is an env file ok? maybe use bitwarden?)


```nix 
  services.borgbackup.jobs."test-borgbase-backup" = {
    paths = [ 
      "test_backup/Camera"
      "test_backup/Music"
      "test_backup/Sync"
      "whatever..."
    ];
    startAt = "hourly";
    repo = "ssh://xyz@xyz.repo.borgbase.com/./repo";
    user = "user_name"; # a user with access to the files to backup, and the keys
    doInit = false;     # The remote repo on borgbase was already initialized.
    environment = {
      BORG_RSH = "ssh -i /keys/id_ed25519";
      BORG_KEY_FILE = "/keys/borgbase-borg-key"; # keyfile "exported" from the repo. 
                                                    # (it actually lives in ~/.config/borg/keys)
    };
    encryption = {
      mode = "keyfile";
      passCommand = "echo ''"; # The keyfile has no passphrase. (press enter when prompted)
    };
    prune.keep = {
      within = "1d"; # Keep all archives from the last day
      daily = 7;     # Keep daily archives for a week
      weekly = 4;    # Keep weekly archives for a month
      monthly = 6;   # Keep monthly archives for half a year
    };
  };
```
