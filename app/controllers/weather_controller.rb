# app/controllers/weather_controller.rb
class WeatherController < ApplicationController
  def index
  end

  def forecast
    service = OpenWeatherMap::Forecast.new('forecast')
    response = service.forecast(params[:city])
    @new_forcast = OpenWeatherMap::FilterMinMax.new(response).get_data
    if @new_forcast.present?
      render :forecast
    else
      flash[:warning] = 'No city found Please check if city exist' if @forecast.nil?
      render :index
    end
  end

  def current_weather
    service = OpenWeatherMap::Forecast.new('weather')
    @city = params[:city]
    @weather_data = service.forecast(@city)
  end
end

