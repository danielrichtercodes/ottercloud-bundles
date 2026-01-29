{{- define "velero.schedule.policy.pv-pvc" -}}
snapshotMoveData: true
includedNamespaces:
  - "*"
labelSelector:
  matchLabels:
    backup.velero.io/enabled: "true"
{{/*includedNamespaceScopedResources:*/}}
{{/*  - persistentvolumeclaims*/}}
{{/*includedClusterScopedResources:*/}}
{{/*  - persistentvolumes*/}}
{{/*excludedClusterScopedResources:*/}}
{{/*  - namespaces*/}}
{{/*  - volumesnapshotclasses.snapshot.storage.k8s.io*/}}
{{/*  - volumesnapshotcontents.snapshot.storage.k8s.io*/}}
{{/*excludedNamespaceScopedResources:*/}}
{{/*  - volumesnapshots.snapshot.storage.k8s.io*/}}
{{- end }}