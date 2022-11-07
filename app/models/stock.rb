class Stock < ApplicationRecord
    
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      secret_token: 'sk_8e2e931a4b764ea2b35d0b5b2fad27e6',
      endpoint: 'https://cloud.iexapis.com/v1'
    )

    client.quote(ticker_symbol).latest_price
  end
    
end