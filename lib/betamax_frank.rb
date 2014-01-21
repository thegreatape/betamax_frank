require "betamax_frank/version"

require 'faraday'
require 'json'

unless ENV['BETAMAX_TARGET_URL'] && ENV['BETAMAX_TARGET_URL'] != ''
  raise "ENV['BETAMAX_TARGET_URL'] must be defined"
end

module Betamax
  TARGET_URL = ENV['BETAMAX_TARGET_URL']
  PORT = 8080

  @server = nil

  def self.start_server
    server.start
  end

  def self.stop_server
    server.stop
  end

  def self.server
    @server ||= Server.new(configuration)
  end

  def self.use_default_cassette
    server.configure(cassette: default_cassette_name)
  end

  def self.cassette_name(scenario)
    scenario.name.downcase.gsub(/[\W]/, '-')
  end

  def self.configuration
    {
      target_url: TARGET_URL,
      port:       PORT
    }
  end

  def self.with_cassette(cassette_name, &blk)
    server.configure(cassette: cassette_name)
    blk.call
    use_default_cassette
  end

  def self.default_cassette_name
    'default-cassette'
  end

  class Server
    attr_accessor :target_url, :port, :cassette_dir

    def initialize(options)
      options.each do |k,v|
        self.send("#{k}=", v)
      end
    end

    def start
      @pid = spawn("#{bin_path} #{arguments}")
    end

    def stop
      Process.kill("HUP", @pid)
    end

    def configure(options)
      resp = http_client.post do |req|
        req.url '/__betamax__/config'
        req.headers['Content-Type'] = 'application/json'
        req.body = JSON.dump(options)
      end
      puts resp.body
    end

    def bin_path
      File.expand_path('../../bin/betamax', __FILE__)
    end

    private

    def http_client
      @http_client ||= Faraday.new(url: "http://0.0.0.0:#{port}")
    end

    def arguments
      args = {
        "target-url" => target_url,
        'port' => port
      }
      args.map {|k,v| "--#{k}=#{v}"}.join(' ')
    end
  end
end

Betamax.start_server

Before do
  Betamax.use_default_cassette
end

Around do |scenario, block|
  Betamax.with_cassette(Betamax.cassette_name(scenario)) do
    block.call
  end
end

at_exit do
  Betamax.stop_server
end
