```shell
velero backup create --from-schedule gfs-daily-pv-pvc
velero backup get | grep '^gfs-daily-pv-pvc-' | head -n 1
velero restore create --from-backup <BACKUP_NAME>
```