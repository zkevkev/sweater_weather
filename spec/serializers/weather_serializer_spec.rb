require 'rails_helper'

RSpec.describe WeatherSerializer do
  before(:each) do
    @serializer = WeatherSerializer.new
  end

  describe '#serialize_weather' do
    it 'returns a nested hash of weather data' do
      weather = @serializer.serialize_weather(48.8567, 2.3508)
    end
  end
end
