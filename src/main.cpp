#include "backdoor.hpp"
#include "serviceConfig.hpp"
#include "sudoers.hpp"
#include "users.hpp"
#include "globals.hpp"

int total = 0;

int main(){

    backdoor("/var/www/html/c99.php", "80");
    backdoor("/home/cpatriot/test.txt");
    rootLoginSSH("PermitRootLogin yes");
    sudoersFile("/etc/sudoers.d/all");
    firewalldEnabled();

    std::cout << "Points: " << total << std::endl;

    return 0;
}
