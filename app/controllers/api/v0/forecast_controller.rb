class Api::V0::ForecastController < ApplicationController
  def show
    geocoder = GeocodingFacade.new
    weather_serializer = WeatherSerializer.new
    location = params[:location].split(',')
    lat_lng = geocoder.lat_lon(location[0], location[1])
    render json: weather_serializer.serialize_weather(lat_lng[:lat], lat_lng[:lon])
  end
end
