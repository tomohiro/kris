require 'active_support/inflector'

module Kris
  class Plugin
    class << self
      def autoload(plugin_path = nil)
        return unless plugin_path

        plugin_files(plugin_path).each do |file|
          require file
          yield const_get(filename_classify(file))
        end
      end

      def filename_classify(file)
        File.basename(file, '.rb').camelize
      end

      def plugin_files(plugin_path)
        Dir[File.join(File.expand_path(plugin_path), '*.rb')]
      end
    end

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
        response(message) if respond_to?(:response)
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

      def logger
        @robot.logger
      end

    private
      def load_callbacks
        Zircon::COMMAND_NAMES.each do |command|
          method_name = "on_#{command.downcase}"
          next unless respond_to?(method_name)

          @robot.send(method_name) do |message|
            send(method_name, message)
          end
        end
      end

      def start_notification_scheduler
        return unless respond_to?(:notify)
        Thread.start do
          loop do
            notify
            sleep 1
          end
        end
      end
  end
end
