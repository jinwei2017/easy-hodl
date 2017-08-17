require 'sinatra'
require "sinatra/activerecord"
require 'json'
require './truelayer'

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

    private
    def truelayer_client
        @truelayer_client ||= TrueLayer.new(ENV["TRUELAYER_CLIENT_ID"], ENV["TRUELAYER_CLIENT_SECRET"])
    end
end