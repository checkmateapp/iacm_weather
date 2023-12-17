# spec/models/open_weather_map/forecast_spec.rb

require 'rails_helper'
require 'httparty'

RSpec.describe OpenWeatherMap::Forecast, type: :model do
  let(:api_key) { '6187b48a3845dbe7191c3e120ab2a4d2' } # replace with your test API key
  let(:get_condition) { 'forecast' }
  let(:forecast_instance) { OpenWeatherMap::Forecast.new(get_condition) }

  describe '#forecast' do
    it 'returns forecast data for a city' do
      city = 'London'
      allow(Rails.application.credentials).to receive(:open_weather_map).and_return(api_key: api_key)

      # Stub the HTTParty.get method to avoid making actual API requests in tests
      allow(HTTParty).to receive(:get).and_return({ 'dummy' => 'forecast_data' })

      # Stub the geocode method to avoid making actual requests to OpenWeatherMap API
      allow_any_instance_of(OpenWeatherMap::Geocode).to receive(:geocode).and_return([{ 'lat' => '51.5074', 'lon' => '-0.1278' }])

      result = forecast_instance.forecast(city)

      expect(result).to eq({ 'dummy' => 'forecast_data' })
    end
  end

end
