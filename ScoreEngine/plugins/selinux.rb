# ./plugins/hello_world.rb
load 'message_plugin.rb'

class SELinux < MessagePlugin

  def initialize
    @name="Score Engine login.defs Plugin"
    @description="This is a plugin for the Score Engine used for the Fedora "\
                 "Cyber Patriots image. It checks to see if SELinux is enabled"\
                 "and being enforced. "
    @currentPoints=0 
    @totalPoints=10
    @success='<font color="green"><b>[+]</b></font>'
    @error='<font color="red">[!]</font>'
    
    # Structure for return results
    @result={}
    @result['name']=@name
    @result['description']=@description
    @result['status']=""
    @result['currentPoints']=0
    @result['totalPoints']=10
  end
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
    rc = `/usr/sbin/getenforce`
    puts "RC = #{rc}"

    if rc.include? "Enforcing" and configOk == true
      @result['currentPoints']=10
      @result['status'] = @success+ " SELinux enabled"
    else 
      @result['currentPoints']=0
      @result['status'] = @error + " SELinux not enabled"
    end
    return @result
  end
end
