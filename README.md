# Setup Instructions

1. Download Fedora 26/27
https://getfedora.org/en/workstation/download/

    TIP: Press on the Download ICON at the top of the page to download the ISO file.

2. Install Fedora 26/27
  - Nothing special.  Use the ISO file since it's more familiar. Create a Cyber Patriot (cpatriot) user id and assign the password "cyber-patriot" to both root and the Cyber Patriot user.

3. Make sure sshd is running on the VM. Login locally through the VM console as root, open a terminal and run the following commands:
   systemctl enable sshd
   systemctl start sshd

TIP: Make sure you are **root** on your local machine before executing the following commands.  The Ansible Playbook will check for the existence of an ssh key for the **root** user on your local machine and generate one if needed.

5. Become the root user on your local machine
````
[claudiol@fedora26 ~]$ su - 
Password: 
[root@fedora26 ~]# 
````

6. Clone the cyber-patriot repository from github.com
````
[root@fedora26 ~]# git clone https://github.com/claudiol/cyber-patriots.git
Cloning into 'cyber-patriots'...
remote: Counting objects: 63, done.
remote: Compressing objects: 100% (41/41), done.
remote: Total 63 (delta 13), reused 62 (delta 12), pack-reused 0
Unpacking objects: 100% (63/63), done.
[root@fedora26 ~]# 
````

7. cd to the cyber-patriots directory

8. Create an encrypted password.yml file using the ansible-vault command that containts the password for the Cyber Patriot VM. 
````
[root@fedora26 roles]# ansible-vault create password.yml
````

This command will first ask you for a secret and then put you in VI mode to edit the file. The contents of the file should look like this:
````
r_password: "cyber-patriot"
````

Save the file. 

TIP: In VI, or VIM, you can save the file by typing the **:wq** command.

9. Now move the file to the roles/cpatriot-fedora-setup/defaults/ directory.
```
[root@fedora26 cyber-patriots]# mv password.yml roles/cpatriot-fedora-setup/defaults/
```

10. From the **cyber-patriots* subdirectory run the  cpatriot-fedora-setup Ansible role from your machine like so:

````
root@fedora26 roles]# ansible-playbook --ask-vault-pass main.yml 
Vault password: 

PLAY [all] ***************************************************************************

TASK [cpatriot-fedora-setup : Checking for ssh key existence] ************************
ok: [192.168.124.75]

TASK [cpatriot-fedora-setup : Generating ssh key for root] ***************************
skipping: [192.168.124.75]

TASK [cpatriot-fedora-setup : Add ssh key] *******************************************
changed: [192.168.124.75] => (item=192.168.124.75)

TASK [cpatriot-fedora-setup : Cleaning yum cache] ************************************
 [WARNING]: Consider using yum module rather than running yum

changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Refreshing yum cache] **********************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding libselinux python package] **********************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Disabling SELinux] *************************************
 [WARNING]: SELinux state temporarily changed from 'enforcing' to 'permissive'. State
change will take effect next reboot.

changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Stop firewalld service] ********************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding python2-devel package] **************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding httpd package] **********************************
ok: [192.168.124.75]

TASK [cpatriot-fedora-setup : Enabling httpd] ****************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding scap-workbench package] *************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding openscap security guide package] ****************
ok: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding php package] ************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting all sudoers file] ****************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting php backdoor files] **************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting php backdoor files] **************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Changing root password ...] ****************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Changing login defs file ...] **************************
ok: [192.168.124.75]

TASK [cpatriot-fedora-setup : Creating Leon user] ************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting all sudoers file] ****************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Creating jack user] ************************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Creating tyler user] ***********************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Deleting password for tyler] ***************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting sshd config backdoor file] *******************
changed: [192.168.124.75]

PLAY RECAP ***************************************************************************
192.168.124.75             : ok=24   changed=20   unreachable=0    failed=0   

[root@fedora26 roles]# 
````
11. Now reboot the VM
