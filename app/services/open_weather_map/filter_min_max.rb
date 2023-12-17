module OpenWeatherMap
  class FilterMinMax
    attr_reader :response
    def initialize(response)
      @response = response
      @forecasts = @response.parsed_response['list']
    end


    def get_data
      @new_forcast = {}
      get_all_uniq_dates.each do |date|
        entries_for_date = @forecasts.select { |entry| Date.parse(entry["dt_txt"]).to_s == date }
        min_temp = entries_for_date.map { |entry| entry["main"]["temp_min"] }.min
        max_temp = entries_for_date.map { |entry| entry["main"]["temp_max"] }.max
        weather_description = entries_for_date.first["weather"].first["description"]

        @new_forcast[date] = {
          "min_temp" => min_temp,
          "max_temp" => max_temp,
          "weather_description" => weather_description
        }
      end

      @new_forcast
    end

    def get_all_uniq_dates
      return @forecasts.map { |entry| Date.parse(entry["dt_txt"]).to_s }.uniq unless @forecasts.nil?
      []
    end
  end
end