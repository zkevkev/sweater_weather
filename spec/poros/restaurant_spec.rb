require 'rails_helper'

RSpec.describe Restaurant do
  before(:each) do
    response = File.read('spec/fixtures/restaurant_response.json')
    details = JSON.parse(response, symbolize_names: true)[:businesses].first
    @restaurant = Restaurant.new(details)
  end

  it 'exists' do
    expect(@restaurant).to be_an_instance_of(Restaurant)
  end

  it 'has attributes' do
    expect(@restaurant.name).to eq("Vinny and Marie’s Italian Street Food")
    expect(@restaurant.address).to eq("Denver, CO 80238")
    expect(@restaurant.rating).to eq(5.0)
    expect(@restaurant.reviews).to eq(6)
  end
end
