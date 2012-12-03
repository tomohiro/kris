module Kris
  class Plugin
    class << self
      def autoload(robot)
        Dir.glob(File.expand_path('./plugin/*.rb')).each do |file|
          require file
          klass = eval(filename_classify(File.basename(file, '.rb'))).new(robot)
          yield klass
        end
      end

      def filename_classify(filename)
        filename.split('_').map(&:capitalize).join
      end
    end

    def initialize(robot)
      @robot = robot
    end

    def boot
      @robot.on_privmsg do |message|
        responce(message)
      end

      Thread.start do
        loop do
          notify
          sleep 1
        end
      end
    end

    protected
      # do nothing.
      # override this method.
      def responce(message); end

      # do nothing.
      # override this method.
      def notify; end

      def notice(channel, message)
        @robot.notice(channel, ":#{message}")
      end

      def privmsg(channel, message)
        @robot.privmsg(channel, ":#{message}")
      end

      def reply(channel, reply_to, message)
        privmsg(channel, "#{reply_to}: #{message}")
      end
  end
end
