require 'rails_helper'

RSpec.describe "Forecast" do
  it "get request for /forecast", :vcr do
    get '/api/v0/forecast', params: { location: 'denver,co' }

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(data).to be_a(Hash)
    expect(data[:id]).to be nil
    expect(data[:type]).to eq('forecast')

    attributes = data[:attributes]

    expect(attributes).to be_a(Hash)

    current = attributes[:current_weather]

    expect(current).to be_a(Hash)
    expect(current[:last_updated]).to be_a(String)
    expect(current[:temperature]).to be_a(Float)
    expect(current[:feels_like]).to be_a(Float)
    expect(current[:humidity]).to be_a(Integer)
    expect(current[:uvi]).to be_a(Float)
    expect(current[:visibility]).to be_a(Float)
    expect(current[:condition]).to be_a(String)
    expect(current[:icon]).to be_a(String)
    expect(current[:wind_dir]).to be nil
    expect(current[:cloud]).to be nil

    daily = attributes[:daily_weather]

    expect(daily).to be_a(Array)
    daily.each do |day|
      expect(day[:date]).to be_a(String)
      expect(day[:sunrise]).to be_a(String)
      expect(day[:sunset]).to be_a(String)
      expect(day[:max_temp]).to be_a(Float)
      expect(day[:min_temp]).to be_a(Float)
      expect(day[:condition]).to be_a(String)
      expect(day[:icon]).to be_a(String)
      expect(day[:maxwind_mph]).to be nil
      expect(day[:totalprecip_in]).to be nil
    end
    expect(daily.length).to eq(5)

    hourly = attributes[:hourly_weather]

    expect(hourly).to be_a(Array)
    hourly.each do |hour|
      expect(hour[:time]).to be_a(String)
      expect(hour[:temperature]).to be_a(Float)
      expect(hour[:conditions]).to be_a(String)
      expect(hour[:icon]).to be_a(String)
      expect(hour[:pressure_mb]).to be nil
      expect(hour[:windchill_f]).to be nil
    end
    expect(hourly.length).to eq(24)
  end
end
