# ./lib/message_plugin.rb
require 'plugin'

class MessagePlugin
  include Plugin

  def get_results
    raise NotImplementedError.new('OH NOES!')
  end
end
