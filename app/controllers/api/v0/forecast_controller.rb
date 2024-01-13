class Api::V0::ForecastController < ApplicationController
  def show
    geocoder = GeocodingFacade.new
    weather_facade = WeatherFacade.new
  end
end
