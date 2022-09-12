#!/bin/bash
SM_SERVER_IP=10.173.1.48
set -x

curl -skS https://$SM_SERVER_IP/pub/RHN-ORG-TRUSTED-SSL-CERT --output /etc/pki/trust/anchors/RHN-ORG-TRUSTED-SSL-CERT
update-ca-certificates
rm /mnt/etc/zypp/repos.d/*

#Create after.local
curl -skS https://$SM_SERVER_IP/pub/bootstrap/after.local --output /mnt/etc/init.d/after.local
chmod +x /mnt/etc/init.d/after.local

