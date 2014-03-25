require File.expand_path("../spec_helper.rb", __FILE__)

describe Envred::Loader do
  let(:server) do
    ENV['REDIS_URL'].split('redis://').last.split('/').first
  end

  let(:central) do
    "#{server}/0/~test"
  end

  let(:redis) do
    Redis.new(url: "redis://#{server}/0")
  end

  let(:setenv) do
    { foo: 1, bar: 2 }
  end

  before do
    redis.mapped_hmset("test", setenv)
  end

  describe "#load" do
    it "loads list of set variables" do
      all = Envred::Loader.new(central).load
      all.should have(2).items
      all['foo'].should == '1'
      all['bar'].should == '2'
    end
  end

  describe "#load" do
    it "loads list of set variables and produces an iterator for it" do
      all = {}

      Envred::Loader.new(central).each do |key, val|
        all[key] = val
      end

      all.should have(2).items
      all['foo'].should == '1'
      all['bar'].should == '2'
    end
  end

  describe "#apply" do
    before do
      ENV.delete('foo')
      ENV.delete('bar')
    end

    it "should load proper configuration and set env" do
      env = nil

      Envred::Loader.new(central).apply do
        env = ENV
      end

      env['foo'].should == '1'
      env['bar'].should == '2'
    end

    it "should property pass env to commands" do
      res = nil

      Envred::Loader.new(central).apply do
        res = `echo $foo $bar`.strip
      end

      res.should == "1 2"
    end

    context do
      let(:setenv) do
        { foo: 1, bar: 2, baz: "" }
      end

      before do
        ENV['foo'] = '10'
        ENV['baz'] = '20'
      end

      it "should not change existing keys" do
        res = nil

        Envred::Loader.new(central).apply do
          res = `echo $foo $bar`.strip
        end

        res.should == "10 2"
      end

      it "should remove key if value is empty" do
        res = nil

        Envred::Loader.new(central).apply do
          res = `echo $foo $bar $baz`.strip
        end

        res.should == "10 2"

      end
    end
  end
end
