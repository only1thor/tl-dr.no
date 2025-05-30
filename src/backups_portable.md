# Backups from portable devices

```mermaid
graph TD;
    Ntfy["ntfy.sh - notification service"]
    subgraph Tailscale network
        A[PC]     --> T
        C[phone]  --> T
        subgraph Home server
            subgraph Docker/Podman
                T[Traefik]  --> N[Syncthing]
            end
            B[Borg Backup nix service]
            N --> Bkp[Backup directory]
            Bkp --> B
            S>Sanoid snapshots] --> Bkp
        end
    end
    F[friends server]
    B --> R[Borgbase.net]
    R --if backups fail for
        24h, notify phone--> Ntfy
    Ntfy --> C
    Bkp --zfs send -w, via syncoid--> F
    
    click Ntfy "https://ntfy.sh"
    click R "https://borgbase.com"
    click T "https://traefik.io"
    click B "https://nixos.org/manual/nixos/stable/#module-borgbase"
    click N "https://syncthing.net"
    click S "https://github.com/jimsalterjrs/sanoid"
```
| ℹ️ | zfs send, and sanoid are a work in progress |
|----|---------------------------------------------|

in addition to backing up regularly to Borgbase with the nix service, the ZFS dataset that contains the backup directory can use sanoid to snapshot regularly for local retention.

