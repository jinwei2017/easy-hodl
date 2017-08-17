require_relative '../kraken'

class User < ActiveRecord::Base
    has_many :transactions
    has_many :orders

    def place_order
        if orders.size > 0 then
            tot = total_save_since_date(orders.last.timestamp)
            place_kraken_order(tot) if tot > 0
        else
            place_kraken_order(total_save)
        end
    end

    def total_save
        transactions.sum(:saved)
    end

    def total_save_since_date(date)
        transactions.where("timestamp > ?", date).sum(:saved)
    end

    private
    def place_kraken_order(amount)
        kraken = Kraken.new(self)
        eth_price = kraken.get_gbp_for_eth
        volume = (amount.to_f / (100).to_f) /eth_price
        # kraken.buy_eth(volume)
        orders.create(timestamp: Time.now, eth: volume, currency_spent: (amount.to_f / (100).to_f))
    end
end