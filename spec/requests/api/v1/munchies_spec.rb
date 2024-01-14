require 'rails_helper'

RSpec.describe "Munchies" do
  it "get request for /munchies" do
    get '/api/v1/munchies', params: { location: 'pueblo,co', food: 'italian' }

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(data).to be_a(Hash)
    expect(data[:id]).to be nil
    expect(data[:type]).to eq('munchie')

    attributes = data[:attributes]

    expect(attributes).to be_a(Hash)
    expect(attributes[:destination_city]).to be_a(String)
    expect(attributes[:forecast]).to be_a(Hash)
    expect(attributes[:forecast][:summary]).to be_a(String)
    expect(attributes[:forecast][:temperature]).to be_a(String)

    restaurant = attributes[:restaurant]

    expect(restaurant).to be_a(Hash)
    expect(restaurant[:name]).to be_a(String)
    expect(restaurant[:address]).to be_a(String)
    expect(restaurant[:rating]).to be_a(Float)
    expect(restaurant[:reviews]).to be_a(Integer)
  end
end
