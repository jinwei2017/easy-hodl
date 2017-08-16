require 'rest-client'
require 'json'
require './models/user'

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
        User.where(truelayer_id: credentials_id).first_or_create(truelayer_access_token: access_token, truelayer_refresh_token: refresh_token)
    end

    private

    def get_credentials_id(access_token)
        response = RestClient.get(DATA_URL + '/me', auth_header(access_token))
        body = JSON.parse(response.body)
        body["results"][0]["credentials_id"]
    end
    
    def auth_header(access_token) 
        {Authorization: "Bearer #{access_token}"}
    end

end
