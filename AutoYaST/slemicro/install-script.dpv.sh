#!/bin/bash
set -x


curl -skS https://psuma.geeko.land/pub/RHN-ORG-TRUSTED-SSL-CERT --output /etc/pki/trust/anchors/hub-master-ca
update-ca-certificates



rm /mnt/etc/zypp/repos.d/*

#Create after.local
POD_TYPE=$(echo ${info}|awk -F ";" '{print $5}')
curl -skS https://psuma.geeko.land/pub/bootstrap/suseapac/after.local --output /mnt/etc/init.d/after.local
chmod +x /mnt/etc/init.d/after.local
