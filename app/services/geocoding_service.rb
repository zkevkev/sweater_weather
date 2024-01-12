class GeocodingService
  def conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/")
  end

  def get_lat_lng(city, state)
    response = conn.get("address?key=#{Rails.application.credentials.geocodingapi[:key]}&location=#{city},#{state}")
    hash = JSON.parse(response.body, symbolize_names: true)
    if hash[:error]
      hash.to_json
    else
      { 
        
      }.to_json
    end
  end
end
