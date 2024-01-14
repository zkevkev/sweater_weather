require 'rails_helper'

RSpec.describe RestaurantFacade do
  before(:each) do
    @facade = RestaurantFacade.new
  end

  describe '#restaurant_search' do
    it 'returns a nested hash of restaurant info' do
      restaurant = @facade.restaurant_search(39.74001, -104.99202, 'italian')

      expect(restaurant).to be_a(Hash)
      expect(restaurant[:name]).to be_a(String)
      expect(restaurant[:address]).to be_a(String)
      expect(restaurant[:rating]).to be_a(Float)
      expect(restaurant[:reviews]).to be_a(Integer)
      expect(restaurant[:display_phone]).to be nil
      expect(restaurant[:coordinates]).to be nil
    end
  end
end
