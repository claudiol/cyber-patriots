#include <stdio.h>
#include <selinux/selinux.h>

int check_selinux()
{
  int rc = security_getenforce();
  return rc;
}
