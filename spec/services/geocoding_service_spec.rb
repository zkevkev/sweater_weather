require 'rails_helper'

RSpec.describe GeocodingService do
  before(:each) do
    @service = GeocodingService.new
  end

  describe '#conn' do
    it 'establishes a connection with mapquest geocoding API' do
      expect(@service.conn).to be_a(Faraday::Connection)
    end
  end

  describe '#get_lat_lng' do
    it 'returns a nested hash of location data, including lat and lon' do
      response = @service.get_lat_lng("Denver", "CO")
      lat_lon = response[:results].first[:locations].first[:latLng]
      expect(lat_lon[:lat]).to eq(39.74001)
      expect(lat_lon[:lng]).to eq(-104.99202)
    end
  end
end
