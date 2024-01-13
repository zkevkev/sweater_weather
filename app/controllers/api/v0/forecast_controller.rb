class Api::V0::ForecastController < ApplicationController
  def show
    require 'pry'; binding.pry
    geocoder = GeocodingFacade.new
    weather_serializer = WeatherSerializer.new
    lat_lng = geocoder.lat_lon(params[:location])
  end
end
