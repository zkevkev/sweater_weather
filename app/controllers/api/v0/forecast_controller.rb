class Api::V0::ForecastController < ApplicationController
  def show
    geocoder = GeocodingFacade.new
  end
end
