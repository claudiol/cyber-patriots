# Setup Instructions

1 - Download Fedora 26/27
https://getfedora.org/en/workstation/download/

2 - Install Fedora 26/27
  - Nothing special.  Create a Cyber Patriot (cpatriot) user id and assign the password "cyber-patriot" to both root and the Cyber Patriot user.

3 - Make sure sshd is running on the VM. Login locally through the consile and run:
   systemctl enable sshd
   systemctl start sshd

4 - Run 'yum update -y' on the VM

5 - Copy ssh key for root to the VM

[root@fedora26 roles]# ssh-copy-id 192.168.124.75
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
root@192.168.124.75's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh '192.168.124.75'"
and check to make sure that only the key(s) you wanted were added.

[root@fedora26 roles]#

6 - Run the  cpatriot-fedora-setup Ansible role from your machine
[root@fedora26 roles]# ansible-playbook main.yml

PLAY [all] *****************************************************************************************

TASK [Gathering Facts] *****************************************************************************
ok: [192.168.124.75]

TASK [cpatriot-fedora-setup : Cleaning yum cache] **************************************************
 [WARNING]: Consider using yum module rather than running yum

changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Refreshing yum cache] ************************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding libselinux python package] ************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Disabling SELinux] ***************************************************
 [WARNING]: SELinux state temporarily changed from 'enforcing' to 'permissive'. State change will
take effect next reboot.

changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Stop firewalld service] **********************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding python2-devel package] ****************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding httpd package] ************************************************
ok: [192.168.124.75]

TASK [cpatriot-fedora-setup : Enabling httpd] ******************************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding scap-workbench package] ***************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding openscap security guide package] ******************************
ok: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding php package] **************************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting all sudoers file] ******************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting php backdoor files] ****************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting php backdoor files] ****************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting sshd config backdoor file] *********************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Changing root password ...] ******************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Changing login defs file ...] ****************************************
ok: [192.168.124.75]

TASK [cpatriot-fedora-setup : Creating Leon user] **************************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting all sudoers file] ******************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Creating jack user] **************************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Creating tyler user] *************************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Deleting password for tyler] *****************************************
changed: [192.168.124.75]

PLAY RECAP *****************************************************************************************
192.168.124.75             : ok=23   changed=19   unreachable=0    failed=0  

- Reboot the VM
