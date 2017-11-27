# ./plugins/hello_world.rb
load 'message_plugin.rb'

class SshProtocol < MessagePlugin

  def initialize
    @name="Score Engine sudoers Plugin"
    @description="This is a plugin for the Score Engine used for the Fedora "\
                 "Cyber Patriots image. It checks to see if the SSH Protocol "\
                 "is set to use version 2. "
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
    return checkSSHProtocol()
  end

  def checkSSHProtocol()
    # Check the config file
    if File.exists?("/etc/ssh/ssh_config.d/ssh_protocol.conf")
      if File.readlines("/etc/ssh/ssh_config.d/ssh_protocol.conf").grep("/Protocol 2/").size > 0
        sshProtocolOk = true 
      else
        sshProtocolOk = false
      end 
    end

    # TODO: Check the sudoers file as well

    if sshProtocolOk
      @result['currentPoints']=10
      @result['status'] = @success+ " SSH Protocol configured correctly in /etc/ssh/ssh_config.d/ssh_protocol.conf"
    else 
      @result['currentPoints']=0
      @result['status'] = @error + " SSH Protocol not configured correctly in /etc/ssh/ssh_config.d/ssh_protocol.conf"
    end
    return @result
  end
end
