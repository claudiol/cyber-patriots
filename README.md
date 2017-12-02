# Workstation Requirements

* Fedora 26/27
* Ansible Version 2.3 or above
* Python Version 2 packages
* Rubygems Version 2.6 or above

# Ansible Playbook
The Ansible playbook will install all the necessary packages in the Fedora 26/27 image.  

# ScoreEngine gem
The ScoreEngine gem will be installed by the Ansible Playbook in the target Cyber Patriots Fedora image.  The ScoreEngine will be installed in the /opt/gems/ScoreEngine-0.1 directory.  There is a configuration file under the /opt/gems/ScoreEngine-0.1/conf/score-engine.conf that can be modified depending on your target.  This is a simple scoring engine so it should work as-is.

The ScoreEngine will run as a service under systemd.  You can start/stop/status/restart the engine using systemctl start/stop/status/restart score-engine.service.

The Score engine will generate a simple HTML index.html file under the /var/www/html/index.html.  Students can access the score using your browser on the following URL on their Fedora image: http://localhost


# VM Setup Instructions

1. Download Fedora 26/27
https://getfedora.org/en/workstation/download/

    TIP: Press on the Download ICON at the top of the page to download the ISO file.

2. Install Fedora 26/27
  * You can create a Fedora VM using VMWare Workstation, VMWare Fusion, virt-manager on Linux
  * Nothing special.  Use the ISO file since it's more familiar. Create a Cyber Patriot (cpatriot) user id and assign the password "cyber-patriot" to both root and the Cyber Patriot user.

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

10 - Edit the inventory file and add the IP address for the Fedora VM that you created.  To find out the IP address login locally to the VM using the console and type the following command:

```
[root@desktop ~]# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:4b:4c:cf brd ff:ff:ff:ff:ff:ff
    inet 192.168.124.75/24 brd 192.168.124.255 scope global dynamic ens3
       valid_lft 2967sec preferred_lft 2967sec
    inet6 fe80::c1c1:296f:2cd2:9b1f/64 scope link 
       valid_lft forever preferred_lft forever
[root@desktop ~]# 
```

The inventory file should look like this:
```
localhost ansible_connection=local
[cyber-patriots]
192.168.124.75
```

11. From the **cyber-patriots* subdirectory run the  cpatriot-fedora-setup Ansible role from your machine like so:

````
[root@fedora26 roles]# ansible-playbook --ask-vault-pass main.yml 
Vault password: 

PLAY [all] *********************************************************************

TASK [cpatriot-fedora-setup : Checking for ssh key existence] ******************
ok: [192.168.124.75]

TASK [cpatriot-fedora-setup : Generating ssh key for root] *********************
skipping: [192.168.124.75]

TASK [cpatriot-fedora-setup : Add ssh key] *************************************
changed: [192.168.124.75] => (item=192.168.124.75)

TASK [cpatriot-fedora-setup : Cleaning yum cache] ******************************
 [WARNING]: Consider using yum module rather than running yum

changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Refreshing yum cache] ****************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding libselinux python package] ****************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Stop firewalld service] **************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding python2-devel package] ********************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding httpd package] ****************************
ok: [192.168.124.75]

TASK [cpatriot-fedora-setup : Enabling httpd] **********************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding scap-workbench package] *******************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding openscap security guide package] **********
ok: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding php package] ******************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding ruby package] *****************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Adding ruby package] *****************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting all sudoers file] **********************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting php backdoor files] ********************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting php backdoor files] ********************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Changing root password ...] **********************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Changing login defs file ...] ********************
ok: [192.168.124.75]

TASK [cpatriot-fedora-setup : Creating Leon user] ******************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting all sudoers file] **********************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Creating jack user] ******************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Creating tyler user] *****************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Deleting password for tyler] *********************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Inserting sshd config backdoor file] *************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : upgrade all packages] ****************************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Disabling SELinux] *******************************
 [WARNING]: SELinux state temporarily changed from 'enforcing' to 'permissive'.
State change will take effect next reboot.

changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Copying simple ScoreEngine] **********************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Installing simple ScoreEngine] *******************
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Installing simple ScoreEngine service file] ******
changed: [192.168.124.75]

TASK [cpatriot-fedora-setup : Enabling simple ScoreEngine service] *************
changed: [192.168.124.75]

PLAY RECAP *********************************************************************
192.168.124.75             : ok=31   changed=27   unreachable=0    failed=0   

[root@fedora26 roles]# 
````
12. Now reboot the VM

# Questions

If you have any questions please feel free to ping me at lester@redhat.com


