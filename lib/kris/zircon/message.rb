class Zircon
  class Message
    def body
      params[1].force_encoding('UTF-8')
    end
  end
end
