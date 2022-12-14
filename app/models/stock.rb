class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :user, through: :user_stocks
    
  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      secret_token: 'sk_8e2e931a4b764ea2b35d0b5b2fad27e6',
      endpoint: 'https://cloud.iexapis.com/v1'
    )

    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.quote(ticker_symbol).latest_price)
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker_symbol)
    Stock.where(ticker: ticker_symbol).first
  end
    
end
