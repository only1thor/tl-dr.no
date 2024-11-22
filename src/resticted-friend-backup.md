# Setup a user to allow a friend to use your server for backups
You and a friend want to "swap" some space on each others home servers, to use eachother as a backup target. But you do not want your friend's user to be able to do anything else then administer their backups (in case they get compromized etc.). 
This document outlines stategies to set up an environment to allow a friend to push new backups, list their backups, and recover from their backups using NixOs, and ZFS. 
(friends user is not intended to be able to delete their own backups, as a security measure for them. An attack on their end should not compromize their backup on your server.)

### Resources 
Restricted user chat on [2.5 Admins podcast](https://2.5admins.com/2-5-admins-222/) @ 16m05s. <br>
ZFS deligate dataset to user chat on [2.5 Admins podcast](https://2.5admins.com/2-5-admins-218/) @ 22m25s. <br>

**Providers that allow ZFS send/recive:**
- rsync.net
- zfs.rent
