#!/bin/bash
set -x
SM_SERVER_IP=10.173.1.142


curl -skS https://$SM_SERVER_IP/pub/RHN-ORG-TRUSTED-SSL-CERT --output /etc/pki/trust/anchors/RHN-ORG-TRUSTED-SSL-CERT
update-ca-certificates
rm /mnt/etc/zypp/repos.d/*

#Create boot script and service 
curl -skS https://$SM_SERVER_IP/pub/bootstrap/boot_script.sh --output /mnt/usr/local/bin/boot_script.sh
curl -skS https://$SM_SERVER_IP/pub/bootstrap/run-before-login-prompt.service --output /mnt/etc/systemd/system/run-before-login-prompt.service
chmod +x /mnt/usr/local/bin/boot_script.sh
