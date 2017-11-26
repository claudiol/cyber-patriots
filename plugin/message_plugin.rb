# ./lib/message_plugin.rb
#require './plugin'
load './plugin.rb'

class MessagePlugin
  include Plugin

  def get_results
    raise NotImplementedError.new('OH NOES!')
  end
end
