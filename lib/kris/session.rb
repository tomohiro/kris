require 'zircon'
require 'kris/zircon/message'

module Kris
  class Session < Zircon

    attr_reader :logger

    def initialize(config)
      @logger      = Logger.new(STDOUT)
      @channels    = config.fetch(:channels, nil)
      @plugin_path = config.fetch(:plugin_path, './plugin')
      super(config)
    end

    def start
      @logger.info('Booting Kris...')
      run!
    rescue => e
      @logger.error(e)
    ensure
      part
    end

    protected
      def run!
        Plugin.autoload(@plugin_path) do |plugin|
          @logger.info("#{plugin} loaded.")
          plugin.new(self).boot
        end

        login
        join_to_channels(@channels) if @channels
        wait_message
      end

      def join_to_channels(channels)
        channels.each do |channel|
          join(channel)
        end
      end
  end
end
