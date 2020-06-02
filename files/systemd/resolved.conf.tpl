# This is a template file for systemd.
# It has been customised to allow multiple domains to be used
# See resolved.conf(5) for details

[Resolve]
#DNS=
#FallbackDNS=
{%- if CUSTOM_DOMAINS %}
Domains={{ CUSTOM_DOMAINS }}
{%- else %}
#Domains=
{%- endif %}
#LLMNR=no
#MulticastDNS=no
#DNSSEC=no
#Cache=yes
#DNSStubListener=yes
