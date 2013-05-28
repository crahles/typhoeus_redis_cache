require 'typhoeus_redis_cache/version'
require 'typhoeus'
require 'redis'
require 'oj'

module TyphoeusRedisCache


  class Cache
    attr_accessor :redis, :ttl

    def initialize(redis = nil, ttl = nil)
      raise ArgumentError.new('redis connection missing') unless redis
      @redis = redis
      @ttl = ttl || 600
    end

    def get(request)
      value = @redis.get request.hash
      Oj.load(value) unless value.nil?
    end

    def set(request, response)
      key = request.hash
      unless @redis.exists(key)
        @redis.setex(key, @ttl, Oj.dump(response))
      end
      response
    end
  end
end
