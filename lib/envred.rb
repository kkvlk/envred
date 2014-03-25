require "envred/version"
require "redis"

module Envred
  class Central
    def initialize(central)
      @server, @app = central.split("/~")
      @redis = Redis.new(url: "redis://#{@server}")
    end
  end

  class Loader < Central
    def load
      @redis.hgetall(@app)
    end

    def each(*args, &block)
      load.each(*args, &block)
    end

    def apply
      each do |key, val|
        if val == ''
          ENV.delete(key)
        else
          ENV[key] = val if ENV[key] === nil
        end
      end

      yield if block_given?
    end
  end

  class Setter < Central
    def set(*values)
      @redis.hmset(@app, *values)
    end

    def unset(*keys)
      @redis.hdel(@app, *keys)
    end
  end

  class Purgator < Central
    def purge
      @redis.del(@app)
    end
  end
end
