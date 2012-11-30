require 'zircon'

module Kris
  class Session
    def initialize(config)
      @logger = Logger.new(STDOUT)
      @robot  = Zircon.new(config)
    end

    def start
      @logger.info('Booting Kris...')
      @logger.info(@robot.username)

      Plugin.autoload(@robot) do |plugin|
        @logger.info("#{plugin.class} loaded.")
        plugin.boot
      end

      @robot.run!
    rescue => e
      @logger.error(e)
    ensure
      @robot.part
    end
  end
end
