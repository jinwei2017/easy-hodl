require 'rest-client'
require 'json'
require './models/user'
require './models/transaction'
require 'digest'

class TrueLayer
    AUTH_URL = "https://auth.truelayer.com".freeze
    DATA_URL = "https://api.truelayer.com/data/v1".freeze
    REDIRECT_URI = 'cryptosaver://truelayer'.freeze
    GRANT_TYPE = 'authorization_code'


    def initialize(client_id, client_secret)
        @client_id = client_id
        @client_secret = client_secret
    end

    def user_with_code(code)
        response = RestClient.post(AUTH_URL + '/connect/token', {
            grant_type: GRANT_TYPE,
            client_id: @client_id,
            client_secret: @client_secret,
            redirect_uri: REDIRECT_URI,
            code: code
        })

        body = JSON.parse(response.body)
        access_token = body["access_token"]
        refresh_token = body["refresh_token"]
        credentials_id = get_credentials_id(access_token)
        user = User.where(truelayer_id: credentials_id).first
        if user then
            user.update(truelayer_access_token: access_token, truelayer_refresh_token: refresh_token)
        else
            user = User.create(truelayer_id: credentials_id, truelayer_access_token: access_token, truelayer_refresh_token: refresh_token)
        end
        user
    end

    def fetch_user_transactions(user)
        account_ids = fetch_account_ids(user)
        account_ids.each do |account_id|
            fetch_transactions(user, account_id)
        end
    end

    private

    def fetch_account_ids(user)
        response = RestClient.get(DATA_URL + '/accounts', auth_header(user.truelayer_access_token))
        body = JSON.parse(response.body)
        body["results"].map {|account| account["account_id"]}
    end

    def fetch_transactions(user, account_id)
        response = RestClient.get(DATA_URL + "/accounts/#{account_id}/transactions", auth_header(user.truelayer_access_token))
        body = JSON.parse(response.body)
        body["results"].map {|transaction| store_transaction(user, transaction)}
    end

    def store_transaction(user, transaction)
        transaction_id = hash_transaction(transaction, user)
        currency = transaction["currency"]
        description = transaction["description"]
        timestamp = Time.new(transaction["timestamp"])
        amount = (transaction["amount"] * 100).to_int.abs
        saved = (amount % 100) > 0 ? (100 - (amount % 100)) : 0
        Transaction.where(transaction_id: transaction_id).first_or_create(transaction_id: transaction_id, currency: currency, description: description, timestamp: timestamp, amount: amount, saved: saved, user_id: user.id)
    end

    def hash_transaction(transaction, user)
        Digest::SHA256.hexdigest(user.truelayer_id + transaction["timestamp"] + transaction["description"])
    end

    def get_credentials_id(access_token)
        response = RestClient.get(DATA_URL + '/me', auth_header(access_token))
        body = JSON.parse(response.body)
        body["results"][0]["credentials_id"]
    end
    
    def auth_header(access_token) 
        {Authorization: "Bearer #{access_token}"}
    end

end
