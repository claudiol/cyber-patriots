# ./plugins/hello_world.rb
load 'message_plugin.rb'
require 'pty'
require 'expect'
require 'etc'

class UserCheck < MessagePlugin

  def initialize
    @name="Score Engine sudoers Plugin"
    @description="This is a plugin for the Score Engine used for the Fedora "\
                 "Cyber Patriots image. It will attempt to become the user tyler, jack "\
                 " and also root with the default passwords assigned. "
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
    return checkUsers()
  end

  def checkUsers()

    # Check the config file
    if File.exists?("/etc/sudoers.d/all")
      canBecomeRoot = true 
    else
      canBecomeRoot = false
    end 


    jackCheckPassed = false
    rootCheckPassed = false
    tylerCheckPassed = false

    STDOUT.sync     = true
    STDERR.sync     = true
    $expect_verbose = true
    password_pat    = %r/^\s*Password:/io


    if canBecomeRoot == false
      
      begin
        if Etc.getpwnam('tyler')

          # Check tyler first ... he doesn't have a password
          PTY.spawn("su - tyler") do |r_f,w_f,pid|
            w_f.sync = true
            r_f.expect(password_pat, timeout=2){ w_f.puts "\n\n\n" }
          end
          checkUser = `whoami`

          if ( checkUser.include?("tyler") )
            tylerCheckPassed = false
          end
        end
      rescue 
        puts 'I am rescued.'  
      end  

      # Check root next ... has a weak password
      PTY.spawn("su - root" ) do |r_f,w_f,pid|
        w_f.sync = true
        r_f.expect(password_pat, timeout=2){ w_f.puts "root\n\n\n" }
      end
      checkUser = `whoami`

      if ( checkUser.include?("root") )
        rootCheckPassed = false
      else
        rootCheckPassed = true
      end

      begin 
        if Etc.getpwnam('jack')
          # Check jack next ... has a weak password
          PTY.spawn("su - jack") do |r_f,w_f,pid|
            w_f.sync = true
            r_f.expect(password_pat, timeout=2){ w_f.puts "jack\n\n\n" }
          end
          checkUser = `whoami`
  
          if ( checkUser.include?("jack") )
            jackCheckPassed = false
          end
        end
      rescue 
        puts 'I am rescued.'  
      end  

      if jackCheckPassed and rootCheckPassed and tylerCheckPassed and canBecomeRoot == false
        @result['currentPoints']=10
        @result['status'] = @success + " Rectified all user passwords and /etc/sudoers.d/all file removed"
      else 
        @result['currentPoints']=0
        @result['status'] = @error + " 'all' file exists in /etc/sudoers.d directory and weak passwords still in place for users tyle, jack and root"
      end
    else
        @result['currentPoints']=0
        @result['status'] = @error + " 'all' file exists in /etc/sudoers.d directory and weak passwords still in place for users tyle, jack and root"
    
    end

    return @result
  end
end
