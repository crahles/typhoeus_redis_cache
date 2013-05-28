module TyphoeusRedisCache

  describe Cache do

    let(:redis) { Redis.new } # this will be captured by fakeredis
    let(:ttl) { 10 } # default ttl to expire cached keys
    let(:cache) { Cache.new redis }

    describe '#initialize' do

      it 'raise an ArgumentError if no redis connection given' do
        expect { Cache.new }.to raise_error ArgumentError
      end

      it 'take the redis connection' do
        expect(cache.redis).to eq redis
      end

      it 'use default ttl 600 seconds when nothing supplied' do
        expect(cache.ttl).to eq 600
      end

      it 'use the ttl (10 seconds) when supplied' do
        expect(Cache.new(redis, ttl).ttl).to eq ttl
      end
    end

    context 'when cache activated' do
      let(:options)  { {} }
      let(:request)  { Typhoeus::Request.new('http://www.example.com', options) }
      let(:response) { Typhoeus::Response.new(code: 200, body: "{'name' : 'paul'}") }

      before { Typhoeus::Config.cache = cache  }
      after { Typhoeus::Config.cache = false }

      context 'when request new' do
        it 'fetches response' do
          expect(request.run).to_not be(response)
          expect(redis.exists(request.hash)).to be_true
        end
      end

      context 'when request in memory' do
        before { redis.set(request.hash, Oj.dump(response)) }

        it 'finishes request' do
          response = request.run
          expect(response.code).to eq response.code
          expect(response.body).to eq response.body
        end
      end
    end
  end
end
