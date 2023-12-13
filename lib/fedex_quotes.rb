# frozen_string_literal: true

require 'httparty'
require 'fedex_quotes/auth'
require 'fedex_quotes/quote'
require 'dotenv/load'
require 'json'
Dotenv.load('keys.env')

module Fedex
  class Rates
    def self.get(params, credentials = nil)
      new(params, credentials).get
    end

    def initialize(params, credentials)
      @params = params
      @credentials = credentials
    end

    # get quotes and parse them into an array of hashes
    def get
      quotes = Quote.fedex_quotes(@params, @credentials)['output']['rateReplyDetails']

      parse_responses(quotes)
    end

    private

    # porse responses into an array of hashes
    def parse_responses(quotes)
      @responses = quotes.map do |quote|
        {
          "price": convert_prices(quote['ratedShipmentDetails'].first['totalNetFedExCharge']),
          "currency": 'mxn',
          "service_level": {
            "name": quote['serviceName'],
            "token": quote['serviceType']
          }
        }
      end
    end

    # convert usd currency to mxn
    def convert_prices(amount)
      (amount * 17.24).round(2) # for demonstration purposes, FedEx Api has problems with global accounts getting amounts in MXN
    end
  end
end
