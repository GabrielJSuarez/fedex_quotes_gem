# frozen_string_literal: true

require 'fedex_quotes/auth'
class Quote
  def self.fedex_quotes(params, credentials)
    new(params, credentials).fedex_quotes
  end

  def initialize(params, credentials)
    @params = params
    @credentials = credentials
  end

  # make post request to FedEx API, this first test iteration is hitting their sandbox endpoint,
  # other iterations will choose prod or sandbox depending the development envoirment
  def fedex_quotes
    response = HTTParty.post((ENV['SANDBOX_QUOTES_URL']).to_s, body: payload, headers:)

    JSON.parse(response.body)
  end

  private

  # retrieve auth token using api key, api secret & account number
  def auth_token
    Auth.auth_token(@credentials)
  end

  # refine headers for http post request
  def headers
    @headers ||= {
      'Content-Type': 'application/json',
      'X-locale': 'es_MX',
      'Authorization': "Bearer #{auth_token}"
    }
  end

  # define payload in JSON format, canse insensitive
  def payload
    @payload ||= JSON.dump(
      {
        "accountNumber": {
          "value": @credentials&.fetch(:account_number) || (ENV['ACCOUNT_NUMBER']).to_s
        },
        "requestedShipment": {
          "shipper": {
            "address": {
              "postalCode": @params[:address_from][:zip]&.to_i,
              "countryCode": @params[:address_from][:country]&.upcase
            }
          },
          "recipient": {
            "address": {
              "postalCode": @params[:address_to][:zip]&.to_i,
              "countryCode": @params[:address_to][:country]&.upcase
            }
          },
          "pickupType": 'CONTACT_FEDEX_TO_SCHEDULE',
          "rateRequestType": %w[LIST PREFERRED],
          "requestedPackageLineItems": [
            {
              "weight": {
                "units": @params[:parcel][:mass_unit]&.upcase,
                "value": @params[:parcel][:weight]&.to_i
              },
              "dimensions": {
                "length": @params[:parcel][:length],
                "width": @params[:parcel][:width],
                "height": @params[:parcel][:height],
                "units": @params[:parcel][:distance_unit]&.upcase
              }
            }
          ]
        }
      }
    )
  end
end
