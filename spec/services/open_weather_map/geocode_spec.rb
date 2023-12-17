# spec/open_weather_map/geocode_spec.rb

require 'rails_helper'
require 'httparty'
require 'open_weather_map/geocode'

RSpec.describe OpenWeatherMap::Geocode do
  describe '#geocode' do
    let(:api_key) { '6187b48a3845dbe7191c3e120ab2a4d2' }
    let(:geocode_instance) { described_class.new(api_key) }
    let(:city) { 'New York' }
    let(:expected_url) { "http://api.openweathermap.org/geo/1.0/direct?q=#{city}&appid=#{api_key}" }

    context 'when making a geocode request' do
      it 'calls HTTParty.get with the correct URL' do
        allow(HTTParty).to receive(:get)
        geocode_instance.geocode(city)
        expect(HTTParty).to have_received(:get).with(expected_url)
      end
    end

    context 'when handling the response' do
      let(:sample_response) { { 'key' => 'value' } }

      before do
        allow(HTTParty).to receive(:get).and_return(sample_response)
      end

      it 'returns the response from HTTParty.get' do
        response = geocode_instance.geocode(city)
        expect(response).to eq(sample_response)
      end
    end
  end
end
