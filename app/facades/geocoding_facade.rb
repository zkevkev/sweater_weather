class GeocodingFacade
  def lat_lon(city, state)
    service = GeocodingService.new
    hash = service.get_lat_lng(city, state)[:results].first[:locations].first[:latLng]
    {
      lat: hash[:lat],
      lon: hash[:lng]
    }
  end
end
