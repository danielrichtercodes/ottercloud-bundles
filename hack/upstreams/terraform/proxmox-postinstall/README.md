# TODO Include repositories and "disable subscription nag" https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_cluster_options
# TODO from https://community-scripts.github.io/ProxmoxVE/scripts?id=post-pve-install
```shell 
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/tools/pve/post-pve-install.sh)"
```
# TODO issue certificates

# TODO setup storage and activate snippets and import

# TODO change default port to 443 https://www.vinchin.com/vm-tips/proxmox-default-port.html
```shell
iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 8006
ip6tables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 8006
apt -y install iptables-persistent netfilter-persistent
```
# todo make images available as datasource and allow to filter