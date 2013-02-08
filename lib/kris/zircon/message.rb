class Zircon
  class Message
    def to
      params[0].force_encoding('UTF-8')
    end

    def body
      params[1].force_encoding('UTF-8')
    end
  end
end
