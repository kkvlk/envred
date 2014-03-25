require File.expand_path("../spec_helper.rb", __FILE__)

describe Envred::Setter do
  let(:server) do
    ENV['REDIS_URL'].split('redis://').last.split('/').first
  end

  let(:central) do
    "#{server}/0/~test"
  end

  let(:redis) do
    Redis.new(url: "redis://#{server}/0")
  end

  before do
    redis.flushdb()
  end

  describe "#set" do
    it "should save given variable if non empty" do
      Envred::Setter.new(central).set("foo", 1)
      redis.hget("test", "foo").should == "1"
    end
  end

  describe "#unset" do
    it "should save given variable if non empty" do
      Envred::Setter.new(central).set("foo", 1)
      Envred::Setter.new(central).unset("foo")
      redis.hget("test", "foo").should == nil
    end
  end
end
