class SimpleReply < Kris::Plugin
  def responce(message)
    case message.body.downcase
    when /hello/
      reply(message.to, message.from, 'Hello!')
    end
  end
end
