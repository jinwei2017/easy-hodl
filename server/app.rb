require 'sinatra'
require "sinatra/activerecord"
require 'json'

class EasyHodl < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    post "/code" do
        {auth: "supersecret"}.to_json
    end
end