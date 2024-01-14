require 'rails_helper'

RSpec.describe RestaurantFacade do
  before(:each) do
    @facade = RestaurantFacade.new
  end

  describe '#restaurant_search' do
    it 'returns a nested hash of restaurant info' do
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

      restaurant = @facade.restaurant_search(39.74001, -104.99202, 'italian')

      expect(restaurant).to be_a(Hash)
      expect(restaurant[:name]).to be_a(String)
      expect(restaurant[:address]).to be_a(String)
      expect(restaurant[:rating]).to be_a(Float)
      expect(restaurant[:reviews]).to be_a(Integer)
      expect(restaurant[:display_phone]).to be nil
      expect(restaurant[:coordinates]).to be nil
    end
  end
end
