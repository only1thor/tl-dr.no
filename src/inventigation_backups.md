# resources found while investigating backup solutions

## `only` tool for ssh
[ MagmaSoft Software Wiki/ blog/ posts/ The Only Way For SSH Forced Commands](https://at.magma-soft.at/sw/blog/posts/The_Only_Way_For_SSH_Forced_Commands/)

`only` is a bash script for restricting what commands a user can run over ssh. [(source)](https://at.magma-soft.at/sw/blog/posts/The_Only_Way_For_SSH_Forced_Commands/only)

## BorgBackup
[ BorgBackup](https://www.borgbackup.org/)

Currently BorgBackup is the best candidate for remote backup, due to its deduplication and encryption features, and due to the amount of services that support it, and their pricing.

The one downside is the 






### truckload of links of stuff i have read:
https://ruderich.org/simon/notes/append-only-backups-with-restic-and-rclone
https://restic.readthedocs.io/en/stable/045_working_with_repos.html
https://github.com/borgbackup/borg/issues/3504
https://github.com/borgbackup/borg/pull/4384
https://github.com/borgbackup/borg/issues/3579
https://search.nixos.org/options?channel=24.05&size=50&sort=relevance&type=packages&query=services.borgbackup.jobs.%3Cname%3E.
https://nixos.org/manual/nixos/stable/#module-borgbase
https://borgbackup.readthedocs.io/en/stable/usage/notes.html#append-only-mode-forbid-compaction
https://wiki.nixos.org/wiki/Borg_backup
https://borgwarehouse.com/docs/admin-manual/docker-installation/
https://stackoverflow.com/questions/33713680/ssh-force-command-execution-on-login-even-without-shell#33714333
https://at.magma-soft.at/sw/blog/posts/The_Only_Way_For_SSH_Forced_Commands/
https://docs.ntfy.sh/
https://docs.borgbase.com/setup/borg/