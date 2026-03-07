# ingress consolidator
On Kubernetes there are at least two distinct use cases to discover "ingress like" objects.
1. Building Dashboard / Service Discovery apps (show all available ingresses in cluster)
2. Building DNS Integrations

Unfortunately one must not only consider Ingresses but also Services of type LoadBalancer, CRDS from Traefik or other ingress controllers,
Gateway API resources and external dns Endpoint.

My broader goal is to cover the uses cases of a dashboard to shows apps running in the cluster and syncing those records
with dns like external dns and k8s gateway api. To cleanly separate the uses cases i first want to consolidate all
interesting resources into a single layer.

# Dashboard
Show all entries like homer or heimdall.
Categorize into different dashboard, pages, tags, categories
Display in groups and nice cards
support icons, health check, dns check,https check, api integration (through sidecards), 

# DNS
Coredns based solution to expose services from kubernetes in dns, also support sync with external dns
Should be a coredns plugin that asks the consolidate api.
Can external dns sync from coredns?

Dns consists of infra urls and vanity url, vanity is user facing, 
also expose apiserver in dns