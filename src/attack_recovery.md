# Attack recovery (Ransomware)

In the scenario where the home server has ransomware, and `zfs` snapshots cannot recover my data. The offsite Borgbase backup can be used to recover data. (hopefully verry unlikeley scenario)

The main steps are:

1. Turn off borgbase server side compacting (if enabled), from a know safe PC (live disk?). <br>
    This gives time to recover data before any data is actually deleted on the server.
2. Clean up malware.
3. Enable sftp on borgbase repo, and copy repo onto local system. (safer than editing repo directly.)
4. Follow [documentation to revert any delet transactions by attacker](https://borgbackup.readthedocs.io/en/stable/usage/notes.html#append-only-mode).
5. Mount, and copy data from borg repo back to filesystem.



## Manipulating transaction history.

This is following the steps from the [Borg documentation](https://borgbackup.readthedocs.io/en/stable/usage/notes.html#append-only-mode), using examples from my own simulated test of this scenario.

you may want to start by getting repo info with `borg info [repo-locaton]`. Here the `Repository ID` may come in handy later, if your client has connected to multiple repos.

use `less [repo-location]/transactions` and look for transaction at odd times, or from knownn attack time:

```
transaction 1438   UTC time 2024-11-17T06:00:29.025851
transaction 1442   UTC time 2024-11-17T06:00:31.680865
transaction 1446   UTC time 2024-11-17T06:00:40.691154
transaction 1449   UTC time 2024-11-17T06:00:42.949990
transaction 1453   UTC time 2024-11-17T07:00:05.117055
transaction 1457   UTC time 2024-11-17T07:00:07.928139
transaction 1461   UTC time 2024-11-17T07:00:09.421660
transaction 1464   UTC time 2024-11-17T07:00:10.688233
transaction 1468   UTC time 2024-11-17T08:00:21.924977
transaction 1472   UTC time 2024-11-17T08:00:23.522328
transaction 1476   UTC time 2024-11-17T08:00:27.810536
transaction 1479   UTC time 2024-11-17T08:00:29.436371
transaction 1483   UTC time 2024-11-17T09:00:01.786366
transaction 1487   UTC time 2024-11-17T09:00:03.305158
transaction 1490   UTC time 2024-11-17T09:00:05.578356
transaction 1494   UTC time 2024-11-17T10:09:34.123150  # odd time, possible attack.
transaction 1498   UTC time 2024-11-17T10:11:08.537320  # odd time, possible attack.
transaction 1502   UTC time 2024-11-17T10:11:41.568902  # odd time, possible attack.
```

| ℹ️ | this is a good time to take a `zfs snapshot` of the borg repo. in case of woopsie |
|----|-----------------------------------------------------------------------------------|

Now manipulate the repository to delete the odd transactions:

```zsh
for i in (seq 1491 1502)
    rm -r [repo-location]/data/**/$i 
end
```

The repo will now be in a state that the borg tool will not be happy with. So any command like `borg list` or `borg info` and such will fail. 
You will now need to clear the repo cache:

`borg delete --cache-only [repo-location]`

And then delete the timestamp from the borg client local config folder (`repo-ID` from the `borg info` you ran at the start):

`rm ~/.config/borg/security/[repo-ID]/manifest-timestamp`
