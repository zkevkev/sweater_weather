require 'rails_helper'

RSpec.describe WeatherService do
  before(:each) do
    @service = WeatherService.new
  end

  describe '#conn' do
    it 'establishes a connection with weather API' do
      expect(@service.conn).to be_a(Faraday::Connection)
    end
  end

  describe '#get_current_weather' do
    it 'returns a nested hash of weather data' do
      weather = @service.get_current_weather(48.8567, 2.3508)
      current = weather[:current]
      expect(weather).to be_a(Hash)
      expect(current).to be_a(Hash)
      expect(current[:last_updated]).to be_a(String)
      expect(current[:temp_f]).to be_a(Float)
      expect(current[:feelslike_f]).to be_a(Float)
      expect(current[:humidity]).to be_a(Integer)
      expect(current[:uv]).to be_a(Float)
      expect(current[:vis_miles]).to be_a(Float)
      expect(current[:condition][:text]).to be_a(String)
      expect(current[:condition][:icon]).to be_a(String)
    end
  end

  describe '#get_forecast_daily' do
    it 'returns a nested hash of weather data for each day' do
      weather = @service.get_forecast_daily(48.8567, 2.3508)
      daily = weather[:forecast][:forecastday]
      expect(weather).to be_a(Hash)
      expect(daily).to be_a(Array)
      expect(daily[0][:date]).to be_a(String)
      expect(daily[1][:astro][:sunrise]).to be_a(String)
      expect(daily[2][:astro][:sunset]).to be_a(String)
      expect(daily[3][:day][:maxtemp_f]).to be_a(Float)
      expect(daily[3][:day][:mintemp_f]).to be_a(Float)
      expect(daily[4][:day][:condition][:text]).to be_a(String)
      expect(daily[4][:day][:condition][:icon]).to be_a(String)
    end
  end

  describe '#get_forecast_hourly' do
    it 'returns a nested hash of weather data for each day' do
      weather = @service.get_forecast_hourly(48.8567, 2.3508)
      hourly = weather[:forecast][:forecastday].first[:hour]
      expect(weather).to be_a(Hash)
      expect(hourly).to be_a(Array)
      expect(hourly[0][:time]).to be_a(String)
      expect(hourly[7][:temp_f]).to be_a(Float)
      expect(hourly[15][:condition][:text]).to be_a(String)
      expect(hourly[23][:condition][:icon]).to be_a(String)
    end
  end
end
