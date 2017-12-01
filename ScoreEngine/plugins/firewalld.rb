# ./plugins/hello_world.rb
load 'message_plugin.rb'
require 'json'

class Firewalld < MessagePlugin

  def initialize
    @name="Score Engine SELinux Plugin"
    @description="This is a plugin for the Score Engine used for the Fedora "\
                 "Cyber Patriots image. It checks to see if Firewalld is enabled " \
                 "and running." 
    @currentPoints=0 
    @totalPoints=10
    @success='<font color="green"><b>[+]</b></font>'
    @error='<font color="red">[!]</font>'
    #@success="\e[01;32m[+]\e[00m"
    #@error="\e[01;31m[!]\e[00m"
    
    # Structure for return results
    @result={}
    @result['name']=@name
    @result['description']=@description
    @result['status']=""
    @result['currentPoints']=0
    @result['totalPoints']=10
  end

  def get_results
    # This plugin checks if the firewalld is enabled and running 
    return checkFirewalld()
  end

  def checkFirewalld()
    # Check if service is running
    isEnabled = `systemctl status firewalld | grep -i enabled `
    isRunning = `systemctl status firewalld | grep -i running`

    if isEnabled.include?("enabled") and isRunning.include?("running")
      @result['currentPoints']=10
      @result['status'] = @success + " Firewalld service is running and enabled"
    else 
      @result['currentPoints']=0
      @result['status'] = @error+ " Firewalld service is not running and/or enable"
    end
    return @result
  end
end
