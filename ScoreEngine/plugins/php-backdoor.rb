# ./plugins/hello_world.rb
load 'message_plugin.rb'
require 'json'

class PHPBackdoor < MessagePlugin

  def initialize
    @name="Score Engine PHP Backdoor Plugin"
    @description="This is a plugin for the Score Engine used for the Fedora "\
                 "Cyber Patriots image. It checks to see if there's a PHP " \
                 "backdoor installed." 
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
    # This plugin looks at the SELinux config file to see if it's disabled
    return checkPhpFiles()
  end

  def checkPhpFiles()
    # Check the config file
    if File.exists?("/usr/localbin/client.py") and File.exists?("/var/www/html/server.php")
      filesRemoved = false
    else
      filesRemoved = true 
    end 


    if filesRemoved
      @result['currentPoints']=10
      @result['status'] = @success + " backdoor has been removed"
    else 
      @result['currentPoints']=0
      @result['status'] = @error+ " backdoor is still in place."
    end
    return @result
  end
end
