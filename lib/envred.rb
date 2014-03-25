require "envred/version"
require "redis"

class Envred
  def initialize(central)
    @server, @app = central.split("/~")
    @redis = Redis.new(url: "redis://#{@server}")
  end

  def load
    @redis.hgetall(@app) or []
  end

  def apply
    load.each do |key, val|
      if val == ''
        ENV.delete(key)
      else
        ENV[key] = val if ENV[key] === nil
      end
    end

    yield if block_given?
  end

  def set(*values)
    @redis.hmset(@app, *values)
  end

  def unset(*keys)
    @redis.hdel(@app, keys)
  end

  def purge
    @redis.del(@app)
  end
end
