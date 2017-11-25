#include "backdoor.hpp"
#include "serviceConfig.hpp"
#include "sudoers.hpp"
#include "users.hpp"
#include "globals.hpp"

int total = 0;

int main(){

    backdoor("/var/www/html/server.php", "80");
    rootLoginSSH("PermitRootLogin yes");
    versionSSH("Protocol 1");
    sudoersFile("/etc/sudoers.d/all");
    firewalldEnabled();

    std::cout << "Points: " << total << std::endl;

    return 0;
}
