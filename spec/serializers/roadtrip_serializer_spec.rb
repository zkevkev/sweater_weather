require 'rails_helper'

RSpec.describe RoadtripSerializer do
  before(:each) do
    @serializer = RoadtripSerializer.new
  end

  describe '#serialize_roadtrip' do
    it 'returns a nested hash of roadtrip data' do
      response = @serializer.serialize_roadtrip('Cincinatti,OH', 'Chicago,IL')

      expect(response).to be_a(Hash)

      data = response[:data]

      expect(data).to be_a(Hash)
      expect(data[:id]).to be nil
      expect(data[:type]).to eq('road_trip')

      attributes = data[:attributes]

      expect(attributes).to be_a(Hash)
      expect(attributes[:start_city]).to be_a(String)
      expect(attributes[:end_city]).to be_a(String)
      expect(attributes[:travel_time]).to be_a(String)

      weather_at_eta = attributes[:weather_at_eta]

      expect(weather_at_eta).to be_a(Hash)
      expect(weather_at_eta[:datetime]).to be_a(String)
      expect(weather_at_eta[:temperature]).to be_a(Float)
      expect(weather_at_eta[:condition]).to be_a(String)
    end
  end
end
