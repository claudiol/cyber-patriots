# ./plugins/hello_world.rb
load 'message_plugin.rb'

class SELinux < MessagePlugin
  $success="\e[01;32m[+]\e[00m"
  $error="\e[01;31m[!]\e[00m"

  def get_results
    # This plugin looks at the SELinux config file to see if it's disabled
    return checkSELinux()
  end

  def checkSELinux()
    # Check the config file
    if File.readlines("/etc/selinux/config").grep(/SELINUXTYPE=targeted/).size > 0
      configOk = true 
    else
      configOk - false
    end 

    # Check if SELinux is in enforce mode
    rc = system('/usr/sbin/getenforce')
    puts "RC = #{rc}"

    if rc == true and configOk == true
      return $success + " SELinux is targeted"
    else 
      return $error+ " SELinux is not enabled"
    end
  end
end
