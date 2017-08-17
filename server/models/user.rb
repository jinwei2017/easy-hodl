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
        orders.create(timestamp: Time.now, eth: 0.1, currency_spent: amount)
    end
end