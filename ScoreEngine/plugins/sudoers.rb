# ./plugins/hello_world.rb
require 'message_plugin'

class Sudoers < MessagePlugin

  def initialize
    @name="Score Engine sudoers Plugin"
    @description="This is a plugin for the Score Engine used for the Fedora "\
                 "Cyber Patriots image. It checks to see if there's a sudoers"\
                 "file 'all' in the /etc/sudoers.d directory. "
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
    return checkSudoers()
  end

  def checkSudoers()
    # Check the config file
    if !File.exist?("/etc/sudoers.d/all")
      allFileExists = true 
    else
      allFileExists = false
    end 

    # TODO: Check the sudoers file as well

    if allFileExists
      @result['currentPoints']=10
      @result['status'] = @success+ " 'all' file removed from /etc/sudoers.d directory"
    else 
      @result['currentPoints']=0
      @result['status'] = @error + " 'all' file exists in /etc/sudoers.d directory"
    end
    return @result
  end
end
