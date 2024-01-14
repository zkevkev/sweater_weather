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
      restaurant_response = File.read('spec/fixtures/restaurant_response.json')
      
      stub_request(:get, "https://api.yelp.com/v3/businesses/search?categories=italian&latitude=39.74001&limit=1&longitude=-104.99202&sort_by=rating").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'Authorization'=>'Bearer hTdjNJoQPKfqvVZ0lqYJwYhyJVwS9ExkuQGUf9AnrEP9AAKKGPz3YhEfdvtvwltLlGa5UTdw9KXJQkaORI-j0zZJ8B9jU4NGaZhnifR4I-vpAGdOJMBkT5DmFEijZXYx',
       'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: restaurant_response, headers: {})

      response = @service.search(39.74001, -104.99202, 'italian')
      expect(response).to be_a(Hash)
      
      restaurant = response[:businesses]

      expect(restaurant).to be_a(Array)

      details = restaurant.first

      expect(details).to be_a(Hash)
      expect(details[:name]).to be_a(String)
      expect(details[:location]).to be_a(Hash)
      expect(details[:location][:display_address]).to be_a(Array)
      expect(details[:location][:display_address][0]).to be_a(String)
      expect(details[:rating]).to be_a(Float)
      expect(details[:review_count]).to be_a(Integer)
      expect(details[:display_phone]).to be_a(String)
      expect(details[:coordinates]).to be_a(Hash)
    end
  end
end
