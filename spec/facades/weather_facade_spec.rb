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
      expect(weather[:temperature]).to be_a(Float)
      expect(weather[:feels_like]).to be_a(Float)
      expect(weather[:humidity]).to be_a(Integer)
      expect(weather[:uvi]).to be_a(Float)
      expect(weather[:visibility]).to be_a(Float)
      expect(weather[:condition]).to be_a(String)
      expect(weather[:icon]).to be_a(String)
    end
  end

  describe '#daily_forecast' do
    it 'returns a nested array of weather data' do
      weather = @facade.daily_forecast(48.8567, 2.3508)
      expect(weather).to be_a(Array)
      expect(weather[0][:date]).to be_a(String)
      expect(weather[0][:sunrise]).to be_a(String)
      expect(weather[1][:sunset]).to be_a(String)
      expect(weather[2][:max_temp]).to be_a(Float)
      expect(weather[3][:min_temp]).to be_a(Float)
      expect(weather[4][:condition]).to be_a(String)
      expect(weather[4][:icon]).to be_a(String)
    end
  end
end
