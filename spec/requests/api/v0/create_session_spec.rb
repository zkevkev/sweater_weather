require 'rails_helper'

RSpec.describe 'post request for /sessions' do
  context 'with valid parameters' do
    it "returns the appropriate user's api key and email", :vcr do
      user = create(:user)
      user_info = {
        email: user.email,
        password: user.password,
      }

      post '/api/v0/sessions', params: user_info, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

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
    it 'returns an appropriate error', :vcr do
      user_info = {
        email: '',
        password: 'password123',
      }.to_json

      post '/api/v0/sessions', params: user_info, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
    end
  end
end
