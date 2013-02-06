class Reply < Kris::Plugin
  def on_privmsg(message)
    case message.body.downcase
    when /hello/
      reply(message.to, message.from, 'Hello!')
    end
  end
end
