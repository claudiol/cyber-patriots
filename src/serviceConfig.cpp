// serviceConfig.cpp contains functions to check for configuration changes
// in certain services, such as SSH, etc.

#include <iostream>
#include "files.hpp"
#include "globals.hpp"

#define success "\e[01;32m[+]\e[00m"
#define error "\e[01;31m[!]\e[00m"

void rootLoginSSH(const char *searchString){
    // Check to see if insecure configuration options are removed
    // in /etc/ssh/sshd_config

    if( isStringInFile("/etc/ssh/ssh_config.d/ssh_protocol.conf", searchString ) == false){
        std::cout << success << " Root SSH login has been disabled." << std::endl;
            total += 10;
    }
}

void versionSSH( const char *searchString) {
    // Check to see if insecure configuration options are removed
    // in /etc/ssh/ssh_config.d file ssh_protocol.conf

    if( isStringInFile("/etc/ssh/ssh_config.d/ssh_protocol.conf", searchString ) == false){
        std::cout << success << " SSH Protocol for client is 2." << std::endl;
            total += 10;
    }
}

void firewalldEnabled() {
   int rc = system("systemctl status firewalld | grep disabled > /dev/null");
   int rc1 = system("systemctl status firewalld | grep inactive > /dev/null");

   if ( rc > 0 && rc1 > 0) {
      std::cout << success << " Firewalld has been enabled and started." << std::endl;
      total +=10;
   }
}

void sshConfigFile(const char *fileName){
    // This most likely will be looking for a file in /etc/ssh/ssh_config.d/

    if(isFileExist(fileName) == false){
        std::cout << success << " Bad SSH Protocol configuration in "
            << fileName << " fixed." << std::endl;
            total += 10;
    }
}

