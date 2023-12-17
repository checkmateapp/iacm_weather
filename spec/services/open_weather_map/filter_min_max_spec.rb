require 'rails_helper'
require 'webmock/rspec'
require 'open_weather_map/filter_min_max'

RSpec.describe OpenWeatherMap::FilterMinMax do
  describe '#get_data' do
    let(:response_body) do
      # Replace this with a sample OpenWeatherMap API response for testing
      {
        'list' => [
          {
    "dt"=> 1702836000,
    "main"=> {
      "temp"=> 289.99,
      "feels_like"=> 289.09,
      "temp_min"=> 289.56,
      "temp_max"=> 289.99,
      "pressure"=> 1019,
      "sea_level"=> 1019,
      "grnd_level"=> 954,
      "humidity"=> 52,
      "temp_kf"=> 0.43
    },
    "weather"=> [
      {
        "id"=> 801,
        "main"=> "Clouds",
        "description"=> "few clouds",
        "icon"=> "02n"
      }
    ],
    "clouds"=> {
      "all"=> 19
    },
    "wind"=> {
      "speed"=> 3.32,
      "deg"=> 53,
      "gust"=> 6.49
    },
    "visibility"=> 10000,
    "pop"=> 0,
    "sys"=> {
      "pod"=> "n"
    },
    "dt_txt"=> "2023-12-17 18=>00=>00"
  },
  {
    "dt"=> 1702846800,
    "main"=> {
      "temp"=> 288.71,
      "feels_like"=> 287.6,
      "temp_min"=> 287.96,
      "temp_max"=> 288.71,
      "pressure"=> 1019,
      "sea_level"=> 1019,
      "grnd_level"=> 953,
      "humidity"=> 49,
      "temp_kf"=> 0.75
    },
    "weather"=> [
      {
        "id"=> 802,
        "main"=> "Clouds",
        "description"=> "scattered clouds",
        "icon"=> "03n"
      }
    ],
    "clouds"=> {
      "all"=> 34
    },
    "wind"=> {
      "speed"=> 3.39,
      "deg"=> 58,
      "gust"=> 7.4
    },
    "visibility"=> 10000,
    "pop"=> 0,
    "sys"=> {
      "pod"=> "n"
    },
    "dt_txt"=> "2023-12-17 21:00:00"
  }
        ]
      }
    end

    let(:fake_response) { instance_double('Response', parsed_response: response_body) }

    subject { described_class.new(fake_response) }

    it 'returns filtered and formatted forecast data' do
      expected_result = {
        '2023-01-01' => {
          'min_temp' => 10,
          'max_temp' => 25,
          'weather_description' => 'Clear'
        }
      }

      expect(subject.get_data).to eq(expected_result)
    end
  end

  describe '#get_all_uniq_dates' do
    let(:response_body) do
      {
        'list' => [
          { 'dt_txt' => '2023-01-01 12:00:00' },
          { 'dt_txt' => '2023-01-01 15:00:00' },
          { 'dt_txt' => '2023-01-02 12:00:00' },
        ]
      }
    end

    let(:fake_response) { instance_double('Response', parsed_response: response_body) }

    subject { described_class.new(fake_response) }

    it 'returns an array of unique dates' do
      expect(subject.get_all_uniq_dates).to eq(['2023-01-01', '2023-01-02'])
    end
  end
end
