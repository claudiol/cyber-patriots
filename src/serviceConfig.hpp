#ifndef __SERVICECONFIG_H_INCLUDED__
#define __SERVICECONFIG_H_INCLUDED__

void rootLoginSSH(const char *searchString);
void firewalldEnabled();
void selinuxEnabled();
void versionSSH( const char *searchString);
void sshConfigFile(const char *fileName);

#endif
