class RestaurantFacade
  def restaurant_search(lat, lon, cuisine)
    service = RestaurantService.new
    restaurant = service.search(lat, lon, cuisine)[:businesses].first
    {
      name: restaurant[:name],
      address: restaurant[:location][:display_address].first,
      rating: restaurant[:rating],
      reviews: restaurant[:review_count]
    }
  end
end
