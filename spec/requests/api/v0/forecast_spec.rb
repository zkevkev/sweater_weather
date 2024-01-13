require 'rails_helper'

RSpec.describe "Forecast" do
  it "get request for /forecast" do
    get("/api/v0/forecast?location=denver,co")
    expect(response).to be_successful

    json = JSON.parse(response.body symbolize_names: true)
  end
end
