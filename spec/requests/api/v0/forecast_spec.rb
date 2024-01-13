require 'rails_helper'

RSpec.describe "Forecast" do
  it "get request for /forecast" do
    forecast = get("/api/v0/forecast?location=denver,co")
    expect(response).to be_successful

    json = JSON.parse(forecast, symbolize_names: true)
  end
end
