class RestaurantFacade
  def restaurant_search(lat, lon, cuisine)
    service = RestaurantService.new
    response = service.search(lat, lon, cuisine)[:businesses].first
    restaurant = Restaurant.new(response)
    {
      name: restaurant.name,
      address: restaurant.address,
      rating: restaurant.rating,
      reviews: restaurant.reviews
    }
  end
end
