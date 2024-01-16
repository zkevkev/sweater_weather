require 'rails_helper'

RSpec.describe 'post request for /road_trip' do
  context 'with valid api key' do
    it 'returns information about the new roadtrip' do
      trip_info = {
        origin: "Cincinatti,OH",
        destination: "Chicago,IL",
        api_key: "t1h2i3s4_i5s6_l7e8g9i10t11"
      }.to_json

      post '/api/v0/road_trip', params: trip_info, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to be_a(Hash)

      data = parsed[:data]

      expect(data).to be_a(Hash)
      expect(data[:type]).to eq('road_trip')
      expect(data[:id]).to be nil

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

  context 'with invalid api key' do
    it 'returns an appropriate error', :vcr do
      trip_info = {
        origin: "Cincinatti,OH",
        destination: "Chicago,IL",
        api_key: ""
      }.to_json

      post '/api/v0/road_trip', params: trip_info, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to_not be_successful
      expect(response.errors).to eq('Invalid api key, please try again')
    end
  end
end
