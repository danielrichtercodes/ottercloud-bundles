
# Backup
```shell
envdir "/run/etc/wal-e.d/env" /scripts/postgres_backup.sh "/home/postgres/pgdata/pgroot/data"
```

# List Backups
```shell
envdir "/run/etc/wal-e.d/env" wal-g backup-list
```

# Restore
```shell
envdir "/run/etc/wal-e.d/env" /scripts/restore_command.sh "base_000000010000000000000010" "$PGDATA" base_000000010000000000000010 2024-07-05T00:52:53Z 000000010000000000000010
```
```yaml
spec:
  clone:
    cluster: postgresql
    timestamp: 2024-07-05T06:33:39+00:00
```