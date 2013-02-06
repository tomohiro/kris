require 'zircon'
require 'kris/zircon/message'

module Kris
  class Session < Zircon
    def initialize(config)
      @logger   = Logger.new(STDOUT)
      @channels = config.fetch(:channels, nil)
      super(config)
    end

    def run!
      login
      join_to_channels(@channels) if @channels
      wait_message
    end

    def start
      @logger.info('Booting Kris...')

      Plugin.autoload(self) do |plugin|
        @logger.info("#{plugin.class} loaded.")
        plugin.boot
      end

      run!
    rescue => e
      @logger.error(e)
    ensure
      part
    end

    def join_to_channels(channels)
      channels.each do |channel|
        join(channel)
      end
    end
  end
end
