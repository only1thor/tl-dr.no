# resources and notes while investigating backup solutions

## Server side sanitization (off-site)
To protect against an attacker compromizing the on-site backup server, and then the remote/off-site backup target, it is preferable that snapshots can only be deleted by the remote/offsite backup target.
Configuration of this schedule should only be done with a strong login, that is seperate from the login used by the on-site backup server. 
Typically via a hardware key like a Fido2 key, either via a webauthn login or ssh-sk key.

So far only zfs seems to be capable of this due to the non encrypted metadata (snapshots are visible to the off-site target).

The only targets that support this natively are rsync.net and zfs.rent. (or vps hosting).
Rsync.net is not the cheapest, and zfs.rent does not seem to be accepting signups.

## `only` tool for ssh
[ MagmaSoft Software Wiki/ blog/ posts/ The Only Way For SSH Forced Commands](https://at.magma-soft.at/sw/blog/posts/The_Only_Way_For_SSH_Forced_Commands/)

`only` is a bash script for restricting what commands a user can run over ssh. [(source)](https://at.magma-soft.at/sw/blog/posts/The_Only_Way_For_SSH_Forced_Commands/only)

## BorgBackup
[ BorgBackup](https://www.borgbackup.org/)

Currently BorgBackup is the best candidate for remote backup, due to its deduplication and encryption features, and due to the amount of services that support it, and the pricing of the remote options.

The one downside is the recovery steps in case of compromise of the on-site backup server, even with append-only mode. 
see: [attach recovery](attack_recovery.md).

## Restic
**TL;DR**
*pros:*
- supports cheap S3 remote backups
- can be run on may systems due to Golang's compilation support.
*cons:*
- cannot be configured to set server to handle snapshot sanitization.


Supports nearly all the same backup targets as Borg, in addition to S3 backend.

although according to [the threat model](https://github.com/restic/restic/blob/60245970280c6e6442cc57777bd570cb49f66448/doc/design.rst#threat-model) it does not cover the case of a comopromise of the on-site backup server, just like Borg.




### truckload of links of stuff i have read:
https://ruderich.org/simon/notes/append-only-backups-with-restic-and-rclone
https://restic.readthedocs.io/en/stable/045_working_with_repos.html
https://github.com/restic/restic/blob/60245970280c6e6442cc57777bd570cb49f66448/doc/design.rst#threat-model
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
https://arstechnica.com/gadgets/2021/06/a-quick-start-guide-to-openzfs-native-encryption/
https://docs.oracle.com/cd/E19253-01/819-5461/gamnq/index.html
https://jrs-s.net/2018/08/17/zfs-tuning-cheat-sheet/
https://openzfs.github.io/openzfs-docs/man/master/8/zfs-send.8.html