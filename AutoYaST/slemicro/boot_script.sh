#!/bin/bash
SM_SERVER=uyuni-container.site.com
REGISTRATION_KEY=1-slemicro55
# Settings for salt-minion
# SALT_MINION_CONF_DIR="/etc/salt/minion.d"
# SALT_MINION_SERVICE="salt-minion"
# SALT_MINION_DIR="/etc/salt"
SALT_MINION_CONF_DIR="/etc/venv-salt-minion/minion.d"
SALT_MINION_SERVICE="venv-salt-minion"
SALT_MINION_DIR="/etc/venv-salt-minion"
HOSTNAME_PREFIX=lab

# temporarily set SELinux to permissive
setenforce 0
systemctl --now disable transactional-update.timer
curl -skS https://$SM_SERVER/pub/RHN-ORG-TRUSTED-SSL-CERT --output /etc/pki/trust/anchors/RHN-ORG-TRUSTED-SSL-CERT
update-ca-certificates

# Optionally set hostname to a prefix with IP concatenation
# hostset=`hostname -I | cut -f1 -d' '| sed s/\[.]/-/g` && hostnamectl set-hostname $HOSTNAME_PREFIX-$hostset
hostname > $SALT_MINION_DIR/minion_id
echo "master: $SM_SERVER" > $SALT_MINION_CONF_DIR/susemanager.conf
echo "server_id_use_src: adler42" >> $SALT_MINION_CONF_DIR/susemanager.conf
echo "enable_legacy_startup_events: False" >> $SALT_MINION_CONF_DIR/susemanager.conf
echo "enable_fqdns_grains: False" >> $SALT_MINION_CONF_DIR/susemanager.conf
echo "grains:" >> $SALT_MINION_CONF_DIR/susemanager.conf
echo "  susemanager:" >> $SALT_MINION_CONF_DIR/susemanager.conf
echo "    activation_key: $REGISTRATION_KEY" >> $SALT_MINION_CONF_DIR/susemanager.conf
# build the beacons file
echo "beacons:" > $SALT_MINION_CONF_DIR/beacons.conf
echo "  reboot_info:" >> $SALT_MINION_CONF_DIR/beacons.conf
echo "    interval: 10" >> $SALT_MINION_CONF_DIR/beacons.conf
# build the transactional_update.conf file
echo "module_executors:" > $SALT_MINION_CONF_DIR/transactional_update.conf
echo "  - transactional_update" >> $SALT_MINION_CONF_DIR/transactional_update.conf
echo "  - direct_call" >> $SALT_MINION_CONF_DIR/transactional_update.conf
# mv $SALT_MINION_CONF_DIR/transactional_update.conf /root
# touch $SALT_MINION_CONF_DIR/transactional_update.conf
systemctl enable --now $SALT_MINION_SERVICE
sleep 90
touch /root/finishinstall
# Added for systemd service disable
mv  /etc/systemd/system/run-before-login-prompt.service /tmp/
init 6
