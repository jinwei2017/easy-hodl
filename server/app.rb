require 'sinatra'
require "sinatra/activerecord"
require 'json'
require './truelayer'
require './models/order'

class EasyHodl < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    post "/code" do
        user = truelayer_client.user_with_code(params["code"])
        return {secret: user.truelayer_id}.to_json
    end

    get "/transactions" do
        user = User.where(truelayer_id: env["HTTP_AUTHORIZATION"]).first!
        if user.transactions.size == 0 then
            truelayer_client.fetch_user_transactions(user)
            user.reload
        end
        user.transactions.to_json
    end

    get '/orders' do
        user = User.where(truelayer_id: env["HTTP_AUTHORIZATION"]).first!
        user.orders.to_json
    end

    get '/stats' do 
        user = User.where(truelayer_id: env["HTTP_AUTHORIZATION"]).first!
        total_amount = user.transactions.sum(:amount)
        total_save = user.transactions.sum(:saved)
        no_of_transactions = user.transactions.size
        {total_save: total_save, total_amount: total_amount, no_of_transactions: no_of_transactions}.to_json
    end

    patch '/kraken-keys' do
        user = User.where(truelayer_id: env["HTTP_AUTHORIZATION"]).first!
        user.update(kraken_key: params["kraken_key"], kraken_secret: params["kraken_secret"])
        200
    end

    get '/place-orders' do
        User.where.not(kraken_key: nil, kraken_secret: nil).each do |user|
            truelayer_client.fetch_user_transactions(user)
            user.place_order
        end
        200
    end

    private
    def truelayer_client
        @truelayer_client ||= TrueLayer.new(ENV["TRUELAYER_CLIENT_ID"], ENV["TRUELAYER_CLIENT_SECRET"])
    end
end