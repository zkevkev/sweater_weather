class RestaurantService
  def conn
    Faraday.new(url: "https://api.yelp.com/v3/")
  end

  def search(lat, lon, cuisine)
    response = conn.get("businesses/search") do |req|
      req.params['latitude'] = lat
      req.params['longitude'] = lon
      req.params['categories'] = cuisine
      req.params['sort_by'] = 'rating'
      req.params['limit'] = 1
      req.headers['Authorization'] = "Bearer #{Rails.application.credentials.yelp_api[:key]}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
