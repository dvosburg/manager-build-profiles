# AutoYaST profiles for SLE Micro

This directory contains profiles for AutoYaST on SLE Micro and can be used with SUSE Manager's autoinstallation feature.

Unlike other AutoYast profiles, the custom scripting feature is greatly changed.  Only a 'chroot-script' is employed, that employs curl to invoke an 'install-script.sh' from the SUSE Manager server.

Since init-scripts are not used with SLE Micro, it uses an '/etc/init.d/after.local' script to complete the salt minion setup.  Examples of each are included here.

## SLE Micro profiles

* SLE Micro 5.0
  * https://github.com/SUSE/manager-build-profiles#master:OSImage/SUSE-MicroOS50

* SLE Micro 5.1
  * https://github.com/SUSE/manager-build-profiles#master:OSImage/SUSE-MicroOS51

SLE Micro profiles must be built on SLE15 buildhost with activation key with corresponding channels.
When creating OS Image profile in SUMA, it is necessary to specify Kiwi option `--profile <profile>`.
This requires SUSE Manager 4.2.2 or newer.

Available Kiwi profiles:

* SLE Micro 5.0
  * `Default`
  * `Default-RT`

* SLE Micro 5.1
  * `Default`
  * `Default-RT`
  * `Default-kvm`
  * `Default-dasd`
  * `Default-fba`

## Variables in after.local and install-script.sh

Specify the following variable in the install-script.sh file:
---
SM_SERVER_IP
---
Specify these variables in the after.local file
---
SM_SERVER=suma4external.site.com
REGISTRATION_KEY=1-slemicro53
SALT_MINION_CONF_DIR="/etc/venv-salt-minion/minion.d"
SALT_MINION_SERVICE="venv-salt-minion"
SALT_MINION_DIR="/etc/venv-salt-minion"
---
## Variables used in the autoinstallation profile
When the uploaded profile requires variables to be set, navigate to `Systems > Autoinstallation > Profiles`, select the profile to edit, and navigate to the `Variables` tab.
Specify the required variables, using this format:

```
<key>=<value>
```

For all installations, the `$redhat_management_server` variable will be set automatically and does not need to be defined.

These examples use the `$distrotree` variable, which must be defined as the distribution label used with this profile.
Set the variable to the same value that you selected in `Autoinstall Tree` in the `Details` tab.

Example:

```
distrotree=sles_sap15sp2-x86_64
```

when the distribution label is `sles_sap15sp2-x86_64`.

To report a bug or request a change, please use [Bugzilla](https://bugzilla.suse.com) or open a GitHub issue.