require 'rails_helper'

RSpec.describe WeatherSerializer do
  before(:each) do
    @serializer = WeatherSerializer.new
  end

  describe '#serialize_weather' do
    it 'returns a nested hash of weather data' do
      response = @serializer.serialize_weather(48.8567, 2.3508)
      weather = JSON.parse(response, symbolize_names: true)
      data = weather[:data]
      attributes = data[:attributes]

      expect(weather).to be_a(Hash)
      expect(data).to be_a(Hash)
      expect(data[:id]).to be nil
      expect(data[:type]).to eq('forecast')
      expect(attributes).to be_a(Hash)
      expect(attributes[:current_weather]).to be_a(Hash)
      expect(attributes[:daily_weather]).to be_a(Array)
      expect(attributes[:hourly_weather]).to be_a(Array)
    end
  end
end
