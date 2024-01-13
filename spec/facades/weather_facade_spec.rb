require 'rails_helper'

RSpec.describe WeatherFacade do
  before(:each) do
    @facade = WeatherFacade.new
  end

  describe '#current_weather' do
    it 'returns a nested hash of weather data' do
      weather = @facade.current_weather(48.8567, 2.3508)
      expect(weather).to be_a(Hash)
      expect(weather[:last_updated]).to be_a(String)
      expect(weather[:feels_like]).to be_a(Float)
      expect(weather[:humidity]).to be_a(Integer)
      expect(weather[:uvi]).to be_a(Float)
      expect(weather[:visibility]).to be_a(Float)
      expect(weather[:condition]).to be_a(String)
      expect(weather[:icon]).to be_a(String)
    end
  end
end
