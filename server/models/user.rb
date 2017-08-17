class User < ActiveRecord::Base
    has_many :transactions
    has_many :orders
end