require "envred/version"
require "redis"

module Envred
  class Wrapper
    def initialize(central)
      @server, @app = central.split("/~")
      @redis = Redis.new(url: "redis://#{@server}")

      load and yield if block_given?
    end

    def load
      vars = @redis.hgetall(@app) and vars.each do |key, val|
        if ENV[key] === nil
          ENV[key] ||= val
        elsif val == ""
          ENV.delete(key)
        end
      end
    end
  end

  def self.wrap(central, command)
    Wrapper.new(central) do
      system command
    end
  end
end
