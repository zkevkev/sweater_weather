class WeatherService
  def conn
    Faraday.new(url: "http://api.weatherapi.com/v1/")
  end

  def current_weather(lat, lon)
    response = conn.get("current.json?key=#{Rails.application.credentials.weatherapi[:key]}&q=#{lat},#{lon}")
    hash = JSON.parse(response.body, symbolize_names: true)
    if hash[:error]
      hash.to_json
    else
      { 
        
      }.to_json
    end
  end
end
