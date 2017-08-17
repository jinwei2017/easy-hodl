require 'kraken_client'

class Kraken
    def initialize(user = nil)
        if user then
            api_key = user.kraken_api_key
            api_secret = user.kraken_api_secret
            KrakenClient.load({api_key: api_key, api_secret: api_secret}).config.tier        
        end
    end

    def get_gbp_for_eth
        client.public.ticker('XETHZGBP')['XETHZGBP']['a'][0]
    end

    def buy_eth(volume)
        opts = {
            pair: 'ETHEUR',
            type: 'buy',
            ordertype: 'market',
            volume: volume
          }
          client.private.add_order(opts)
    end

    private

    def client
        @client ||= KrakenClient.load
    end
end
