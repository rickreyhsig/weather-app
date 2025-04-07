require "dotenv/load"

class WeatherForecast
  def initialize(client = OpenWeather::Client.new(api_key: ENV["OPENWEATHER_API_KEY"]))
    @client = client
  end

  def process(options = {})
    if options[:city].blank? && options[:zip].blank?
      return { data: nil, error: "Please pass in a city OR zip.", cache: false }
    end

    if options[:zip].present?
      cache_key = "weather_forecast_zip_#{options[:zip]}"
      is_from_cache = Rails.cache.exist?(cache_key)
      response = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
        @client.current_weather({ zip: options[:zip] })
      end
      { data: response, error: nil, cache: is_from_cache }
    else
      # no caching for city-based queries
      response = @client.current_weather({ city: options[:city] })
      { data: response, error: nil, cache: false }
    end
  rescue => e
    { data: nil, error: e.message, cache: false }
  end
end

=begin
  # Usage examples
  client = WeatherForecast.new
  client.process(zip: "20906")
  client.process(zip: "20906", country: "US")
  client.process(city: "Silver Spring")

  data = client.process(city: "Silver Spring")

  data.main.temp_f
  data.main.temp_max_f
  data.main.temp_min_f
=end
