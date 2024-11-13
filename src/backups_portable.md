# Backups from portable devices



```mermaid
graph TD;
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
        end
    end
  B --> R[Borgbase.net]
  
```

in addition to backing up regularly to Borgbase with the nix service, the ZFS dataset that contains the backup directory can use sanoid to snapshot regularly for local retention.

