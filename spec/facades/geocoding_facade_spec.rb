require 'rails_helper'

RSpec.describe GeocodingFacade do
  before(:each) do
    @facade = GeocodingFacade.new
  end

  describe '#lat_lon' do
    it 'returns a hash of latitude and longitude for a location' do
      hash = @facade.lat_lon('Denver', 'CO')
      expect(hash[:lat]).to eq(39.74001)
      expect(hash[:lon]).to eq(-104.99202)
    end
  end
end
