load "./plugin.rb"

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
pluginResults.each do | key, value |

  puts "<pre>"
  puts "    Plugin Name: #{key} "
  puts "    Description: #{value['description']}"
  puts "    Status: #{value['status']}"
  puts "    Points: #{value['currentPoints']}"
  puts "</pre>"
  totalPoints += value['currentPoints']
  maxPoints += value['totalPoints']
end

puts "Total Points: #{totalPoints} out of #{maxPoints}"
