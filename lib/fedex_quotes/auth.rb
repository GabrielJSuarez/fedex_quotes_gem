# frozen_string_literal: true

class Auth
  def self.auth_token(credentials)
    new(credentials).auth_token
  end

  def initialize(credentials)
    @credentials = credentials
  end

  # return JSON with access_token, token_type, expiration time & scope
  def auth_token
    token = HTTParty.post((ENV['SANDBOX_AUTH_URL']).to_s, body: payload,
                                                          headers: {
                                                            'Content-Type' => 'application/x-www-form-urlencoded'
                                                          })

    JSON.parse(token.body)['access_token']
  end

  private

  # for getting the auth token necessary to interface with the FEDEX API
  def payload
    @payload ||= {
      grant_type: 'client_credentials',
      client_id: @credentials&.fetch(:client_id) || ENV['CLIENT_ID'],
      client_secret: @credentials&.fetch(:client_secret) || ENV['CLIENT_SECRET']
    }
  end
end
