require 'rails_helper'

RSpec.describe 'get request for /user' do
  context 'with valid parameters' do
    it 'creates a new user and returns their api key' do
      user_info = {
        email: 'example@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      }.to_json

      post '/api/v0/user', params: user_info, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(201)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to be_a(Hash)

      data = parsed[:data]

      expect(data).to be_a(Hash)
      expect(data[:type]).to eq('users')
      expect(data[:id]).to be_a(Integer)

      attributes = data[:attributes]

      expect(attributes).to be_a(Hash)
      expect(attributes[:email]).to be_a(String)
      expect(attributes[:api_key]).to be_a(String)
    end
  end

  context 'with invalid parameters' do
    it 'returns an appropriate error' do
      user_info = {
        email: 'example@example.com',
        password: 'password123',
        password_confirmation: 'password'
      }.to_json

      post '/api/v0/user', params: user_info, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.errors).to eq("doesn't match Password")
    end
  end
end
