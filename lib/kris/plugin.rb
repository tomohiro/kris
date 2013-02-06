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

    COMMAND_NAMES = %w(
      ADMIN
      AWAY
      CREDITS
      CYCLE
      DALINFO
      INVITE
      ISON
      JOIN
      KICK
      KNOCK
      LICENSE
      LINKS
      LIST
      LUSERS
      MAP
      MODE
      MOTD
      NAMES
      NICK
      NOTICE
      PART
      PASS
      PING
      PONG
      PRIVMSG
      QUIT
      RULES
      SETNAME
      SILENCE
      STATS
      TIME
      TOPIC
      USER
      USERHOST
      VERSION
      VHOST
      WATCH
      WHO
      WHOIS
      WHOWAS
    ).freeze

    def initialize(robot)
      @robot = robot
    end

    def boot
      load_callbacks
      start_notification_scheduler
    end

    protected
      # Call response method is for backwords compatibility
      def on_privmsg(message)
        response(message)
      end

      # Override this method if you want get scheduled notification.
      def notify; end

      def notice(channel, message)
        @robot.notice(channel, ":#{message}")
      end

      def privmsg(channel, message)
        @robot.privmsg(channel, ":#{message}")
      end

      def reply(channel, reply_to, message)
        @robot.privmsg(channel, ":#{reply_to}: #{message}")
      end

    private
      def load_callbacks
        COMMAND_NAMES.each do |name|
          method_name = "on_#{name.downcase}"
          next unless self.class.method_defined?(method_name)

          @robot.send(method_name) do |message|
            send(method_name, message)
          end
        end
      end

      def start_notification_scheduler
        return unless self.class.public_method_defined?(:notify)
        Thread.start do
          loop do
            notify
            sleep 1
          end
        end
      end
  end
end
