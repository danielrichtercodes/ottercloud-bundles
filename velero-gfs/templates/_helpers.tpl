{{- define "velero.schedule.policy.pv-pvc" -}}
snapshotMoveData: true
includedNamespaces:
  - "*"
labelSelector:
  matchLabels:
    backup.velero.io/enabled: "true"
includedNamespaceScopedResources:
  - persistentvolumeclaims
includedClusterScopedResources:
  - persistentvolumes
{{- end }}