load "./plugin.rb"

dir = './plugins'
$LOAD_PATH.unshift(dir)
Dir[File.join(dir, '*.rb')].each {|file| require File.basename(file) }

# Test that we can send a message to each plugin
MessagePlugin.repository.each do |plugin|
  puts plugin.inspect
  result = plugin.new.get_results
  puts result
end
