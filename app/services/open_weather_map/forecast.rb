require 'httparty'

module OpenWeatherMap
  class Forecast
    
    attr_reader :get_condition
    BASE_URL = 'https://api.openweathermap.org/data/2.5'
    FORECAST_WEATHER = 'forecast'.freeze
    CURRENT_WEATHER = 'weather'.freeze

    def initialize(get_condition)
      @api_key = Rails.application.credentials.open_weather_map[:api_key]
      @get_condition = get_condition
    end

    def forecast(city)
      @city = city
      HTTParty.get("#{BASE_URL}/#{get_condition_route[get_condition]}?lat=#{lat}&lon=#{lon}&appid=#{@api_key}")
    end

    private

    def lat
      geocoded_city_response.first['lat'] if geocoded_city_response.first.present?
    end

    def lon
      geocoded_city_response.first['lon'] if geocoded_city_response.first.present?
    end

    def geocoded_city_response
      @geocoded_city_response ||= Geocode.new(@api_key).geocode(@city)
    end

    def get_condition_route
      {
        "forecast" => FORECAST_WEATHER,
        "weather" => CURRENT_WEATHER
      }
    end
  end
end
