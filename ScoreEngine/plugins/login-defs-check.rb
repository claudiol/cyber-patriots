# ./plugins/hello_world.rb
load 'message_plugin.rb'
require 'json'

class LoginDefs < MessagePlugin

  def initialize
    @name="Score Engine login.defs Plugin"
    @description="This is a plugin for the Score Engine used for the Fedora "\
                 "Cyber Patriots image. It checks to see if the PASS_MAX_DAYS "\
                 "value is set to a reasonable requirement."
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
    # This plugin looks at the login.defs file to see if PASS_MAX_DAYS has a value 
    # that is reasonable.  Reasonable to us is a value no greater than 180 days
    return checkLoginDefs()
  end

  def checkLoginDefs()
    # Check the config file
    line = File.readlines("/etc/login.defs").grep(/^PASS_MAX_DAYS/)

    # We split the line so that we can get the value
    key, value = line.to_s.split('\t')

    #puts key
    #puts value
    #puts value.delete!('\\\n"]')

    # Check if the value has a reasonable value.
    if value.to_i > 180
      @result['currentPoints']=0
      @result['status'] = @error+ " not a reasonable value"
    else 
      @result['currentPoints']=10
      @result['status'] = @success + " reasonable value"
    end
    return @result
  end
end
