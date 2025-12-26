# metallb-bgp
Opinionated BGP Peering for metallb as a helm chart

## Example Vyos
```shell
set protocols bgp neighbor 192.168.178.21 address-family ipv6-unicast soft-reconfiguration inbound
set protocols bgp neighbor 192.168.178.21 address-family ipv4-unicast soft-reconfiguration inbound
set protocols bgp neighbor 192.168.178.21 remote-as '64522'
set protocols bgp neighbor 192.168.178.22 address-family ipv6-unicast soft-reconfiguration inbound
set protocols bgp neighbor 192.168.178.22 address-family ipv4-unicast soft-reconfiguration inbound
set protocols bgp neighbor 192.168.178.22 remote-as '64522'
set protocols bgp neighbor 192.168.178.24 address-family ipv6-unicast soft-reconfiguration inbound
set protocols bgp neighbor 192.168.178.24 address-family ipv4-unicast soft-reconfiguration inbound
set protocols bgp neighbor 192.168.178.24 remote-as '64522'
set protocols bgp system-as '64520'
```