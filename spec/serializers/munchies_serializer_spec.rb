require 'rails_helper'

RSpec.describe MunchiesSerializer do
  before(:each) do
    @serializer = MunchiesSerializer.new
  end

  describe '#serialize_munchies' do
    it 'returns a nested hash of weather and restaurant data for a location' do
      response = @serializer.serialize_munchies(39.74001, -104.99202, 'italian')
      munchies = JSON.parse(response, symbolize_names: true)

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
