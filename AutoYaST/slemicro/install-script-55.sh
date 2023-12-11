#!/bin/bash
set -x
SM_SERVER=10.173.1.142


curl -skS https://$SM_SERVER/pub/RHN-ORG-TRUSTED-SSL-CERT --output /etc/pki/trust/anchors/RHN-ORG-TRUSTED-SSL-CERT
update-ca-certificates
rm /mnt/etc/zypp/repos.d/*

#Create after.local
curl -skS https://$SM_SERVER/pub/bootstrap/after.local.54 --output /mnt/etc/init.d/after.local
chmod +x /mnt/etc/init.d/after.local
