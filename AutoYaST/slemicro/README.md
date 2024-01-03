# AutoYaST profiles for SLE Micro

This directory contains profiles for AutoYaST on SLE Micro and can be used with SUSE Manager's autoinstallation feature.

Unlike other AutoYast profiles, the custom scripting feature is greatly changed.  Only a 'chroot-script' is employed, that uses curl to copy the 'install-script.sh' from the SUSE Manager server.

Please edit the 'install-script.sh' with the IP/FQDN of your SUMA server.  An example is included here.
## after.local or systemd scripts
Since init-scripts are not used with SLE Micro, it can use an '/etc/init.d/after.local' script to complete the salt minion setup.  Copy the example 'after.local'  to your SUMA server in /srv/www/htdocs/pub/bootstrap/, and edit as needed.  Variables are at the top.

A more modern way is to use systemd - and some templates are used here in the install-script-55.sh file.  It installs a 'run-before-login-prompt.service file in /etc/systemd/system, and references a 'boot_script.sh' file placed in '/usr/local/bin'.  

## Variables in after.local/systemd and install-script.sh

Set variables in the following files - examples proivided:

* install-script.sh
  * `SM_SERVER_IP=10.173.1.48`

* after.local/boot_script.sh
  * `SM_SERVER=suma4external.site.com`
  * `REGISTRATION_KEY=1-slemicro53`
  * `SALT_MINION_CONF_DIR="/etc/venv-salt-minion/minion.d"`
  * `SALT_MINION_SERVICE="venv-salt-minion"`
  * `SALT_MINION_DIR="/etc/venv-salt-minion"`


## Variables used in the autoinstallation profile
When the uploaded profile requires variables to be set, navigate to `Systems > Autoinstallation > Profiles`, select the profile to edit, and navigate to the `Variables` tab.
Specify the required variables, using this format:

```
<key>=<value>
```

For all installations, the `$redhat_management_server` variable will be set automatically and does not need to be defined.

These examples use the `$distrotree` variable, which must be defined as the distribution label used with this profile.
Set the variable to the same value that you selected in `Autoinstall Tree` in the `Details` tab.

Example here:

```
distrotree=slemicro_53
```

when the distribution label is `slemicro_53`.

To report a bug or request a change, please use [Bugzilla](https://bugzilla.suse.com) or open a GitHub issue.
