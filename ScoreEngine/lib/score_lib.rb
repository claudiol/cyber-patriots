require 'fileutils'
require 'message_plugin'

class ScoreEngine

  #==========================================================================

  VERSION = "1.0.0"

  def self.run!(options)
    ScoreEngine.new(options).run!
  end

  #==========================================================================

  attr_reader :options, :quit

  def initialize(options)
    @options = options
    options[:logfile] = File.expand_path(logfile) if logfile?   # daemonization might change CWD so expand any relative paths in advance
    options[:pidfile] = File.expand_path(pidfile) if pidfile?   # (ditto)
  end

  def daemonize?
    options[:daemonize]
  end

  def logfile
    options[:logfile]
  end

  def pidfile
    options[:pidfile]
  end

  def logfile?
    !logfile.nil?
  end

  def pidfile?
    !pidfile.nil?
  end

  def info(msg)
    puts "[#{Process.pid}] [#{Time.now}] #{msg}"
  end

  #--------------------------------------------------------------------------

  def run!

    check_pid
    daemonize if daemonize?
    write_pid
    trap_signals

    if logfile?
      redirect_output
    elsif daemonize?
      suppress_output
    end

    while !quit

      dir = './plugins'
      $LOAD_PATH.unshift(dir)
      Dir[File.join(dir, '*.rb')].each {|file| require File.basename(file) }

      pluginResults = {} 
    
      # Test that we can send a message to each plugin
      MessagePlugin.repository.each do |plugin|
        results = plugin.new.get_results
        pluginResults["#{plugin.inspect}"] = results
      end
    
      totalPoints = 0
      maxPoints=0
      begin
      file=File.open("/var/www/html/index.html", 'w+') 
      pluginResults.each do | key, value |
      
        file.write("<title>Cyber Patriots Apache HTTP Server on Fedora</title>\n")
        file.wrire("<h1>Cyber Patriots Scoring Engine</h1>")
        file.write("<pre>\n")
        file.write( "    Plugin Name: #{key} \n")
        file.write( "    Description: #{value['description']}\n")
        file.write( "    Status: #{value['status']}\n")
        file.write( "    Points: #{value['currentPoints']}\n")
        file.write( "</pre>\n")
        totalPoints += value['currentPoints']
        maxPoints += value['totalPoints']
      end
      
      file.write("Total Points: #{totalPoints} out of #{maxPoints}\n")
      file.close
  
      sleep(60)  
      rescue
      end
    end

  end

  #==========================================================================
  # DAEMONIZING, PID MANAGEMENT, and OUTPUT REDIRECTION
  #==========================================================================

  def daemonize
#    exit if fork
#    Process.setsid
#    exit if fork
    Dir.chdir "/tmp/ScoreEngine"
  end

  def redirect_output
    FileUtils.mkdir_p(File.dirname(logfile), :mode => 0755)
    FileUtils.touch logfile
    File.chmod(0644, logfile)
    $stderr.reopen(logfile, 'a')
    $stdout.reopen($stderr)
    $stdout.sync = $stderr.sync = true
  end

  def suppress_output
    $stderr.reopen('/dev/null', 'a')
    $stdout.reopen($stderr)
  end

  def write_pid
    if pidfile?
      begin
        File.open(pidfile, ::File::CREAT | ::File::EXCL | ::File::WRONLY){|f| f.write("#{Process.pid}") }
        at_exit { File.delete(pidfile) if File.exists?(pidfile) }
      rescue Errno::EEXIST
        check_pid
        retry
      end
    end
  end

  def check_pid
    if pidfile?
      case pid_status(pidfile)
      when :running, :not_owned
        puts "A server is already running. Check #{pidfile}"
        exit(1)
      when :dead
        File.delete(pidfile)
      end
    end
  end

  def pid_status(pidfile)
    return :exited unless File.exists?(pidfile)
    pid = ::File.read(pidfile).to_i
    return :dead if pid == 0
    Process.kill(0, pid)
    :running
  rescue Errno::ESRCH
    :dead
  rescue Errno::EPERM
    :not_owned
  end

  #==========================================================================
  # SIGNAL HANDLING
  #==========================================================================

  def trap_signals
    trap(:QUIT) do   # graceful shutdown
      @quit = true
    end
  end

  #==========================================================================

end

