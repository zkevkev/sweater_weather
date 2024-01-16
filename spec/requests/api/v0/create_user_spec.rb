require 'rails_helper'

RSpec.describe 'post request for /user' do
  context 'with valid parameters' do
    it 'creates a new user and returns their api key', :vcr do
      user = build(:user)
      user_info = {
        "email": user.email,
        "password": user.password,
        "password_confirmation": user.password_confirmation
      }

      post '/api/v0/users', params: user_info.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(201)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to be_a(Hash)

      data = parsed[:data]

      expect(data).to be_a(Hash)
      expect(data[:type]).to eq('user')
      expect(data[:id]).to be_a(String)

      attributes = data[:attributes]

      expect(attributes).to be_a(Hash)
      expect(attributes[:email]).to be_a(String)
      expect(attributes[:api_key]).to be_a(String)
    end
  end

  context 'with invalid parameters' do
    it 'returns an appropriate error', :vcr do
      user_info = {
        email: 'example@example.com',
        password: 'password123',
        password_confirmation: 'password'
      }

      post '/api/v0/users', params: user_info.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
    end
  end
end
