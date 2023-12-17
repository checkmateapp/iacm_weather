# config/routes.rb
Rails.application.routes.draw do
  root to: 'weather#index'
  get 'weather/forecast'
  post 'weather/forecast', to: 'weather#forecast'
  get 'weather/current_weather', to: 'weather#current_weather'
end

