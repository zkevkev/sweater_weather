require 'rails_helper'

RSpec.describe "User" do
  it "get request for /user" do
    post '/api/v0/user'
  end
end
