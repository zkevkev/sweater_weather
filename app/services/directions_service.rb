class GeocodingService
  def conn
    Faraday.new(url: "https://www.mapquestapi.com/directions/v2/")
  end

  def get_directions(from, to)
    response = conn.get("route?key=#{Rails.application.credentials.geocodingapi[:key]}&from=#{from}&to=#{to}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
