require 'rails_helper'

RSpec.describe RestaurantService do
  before(:each) do
    @service = RestaurantService.new
  end

  describe '#conn' do
    it 'establishes a connection with Yelp API' do
      expect(@service.conn).to be_a(Faraday::Connection)
    end
  end

  describe '#search' do
    it 'returns a nested hash of resteraunt data' do
      response = @service.search(39.74001, -104.99202, 'italian')
      expect(response).to be_a(Hash)
      
      restaurant = response[:businesses]

      expect(restaurant).to be_a(Array)

      details = restaurant.first

      expect(details).to be_a(Hash)
      expect(details[:name]).to be_a(String)
      expect(details[:location]).to be_a(Hash)
      expect(details[:location][:display_address]).to be_a(String)
      expect(details[:rating]).to be_a(Float)
      expect(details[:review_count]).to be_a(String)
      expect(details[:display_phone]).to be_a(String)
      expect(details[:coordinates]).to be_a(Hash)
      expect(details[:region]).to be_a(Hash)
    end
  end
end
