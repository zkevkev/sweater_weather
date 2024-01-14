require 'rails_helper'

RSpec.describe MunchiesSerializer do
  before(:each) do
    @serializer = MunchiesSerializer.new
  end

  describe '#serialize_munchies' do
    it 'returns a nested hash of weather and restaurant data for a location' do
      geo_response = File.read('spec/fixtures/geocoding_response.json')
      
      stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=6OQk5VF7M8XHeIwKHWymBlr7vaJavhx8&location=39.74001,-104.99202").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: geo_response, headers: {})

      weather_response = File.read('spec/fixtures/weather_response.json')

      stub_request(:get, "http://api.weatherapi.com/v1/current.json?key=a40b7a8012ff42098bf203051240501&q=39.74014,-104.992").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: weather_response, headers: {})

      restaurant_response = File.read('spec/fixtures/restaurant_response.json')

      stub_request(:get, "https://api.yelp.com/v3/businesses/search?categories=italian&latitude=39.74014&limit=1&longitude=-104.992&sort_by=rating").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer hTdjNJoQPKfqvVZ0lqYJwYhyJVwS9ExkuQGUf9AnrEP9AAKKGPz3YhEfdvtvwltLlGa5UTdw9KXJQkaORI-j0zZJ8B9jU4NGaZhnifR4I-vpAGdOJMBkT5DmFEijZXYx',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: restaurant_response, headers: {})

      response = @serializer.serialize_munchies(39.74001, -104.99202, 'italian')
      munchies = weather = JSON.parse(response, symbolize_names: true)

      expect(munchies).to be_a(Hash)

      data = munchies[:data]

      expect(data).to be_a(Hash)
      expect(data[:id]).to be nil
      expect(data[:type]).to eq('munchie')

      attributes = data[:attributes]

      expect(attributes).to be_a(Hash)
      expect(attributes[:destination_city]).to be_a(String)

      forecast = attributes[:forecast]
      
      expect(forecast).to be_a(Hash)
      expect(forecast[:summary]).to be_a(String)
      expect(forecast[:temperature]).to be_a(Float)

      restaurant = attributes[:restaurant]

      expect(restaurant).to be_a(Hash)
      expect(restaurant[:name]).to be_a(String)
      expect(restaurant[:address]).to be_a(String)
      expect(restaurant[:rating]).to be_a(Float)
      expect(restaurant[:reviews]).to be_a(Integer)
    end
  end
end
