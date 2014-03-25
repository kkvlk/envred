require 'rspec'
require 'envred'

ENV['REDIS_URL'] ||= 'redis://localhost:6379/'

RSpec.configure do |rspec|
end
