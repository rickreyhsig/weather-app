require "dotenv/load"
# require "open_weather"

class WeatherForecast
  def initialize
    binding.irb
    @client = OpenWeather::Client.new(api_key: ENV['OPENWEATHER_API_KEY'])
  end

  def process(options = {})
      if options[:city].blank? && options[:zip].blank?
        response = { data: nil, error: 'Please pass in a city OR zip.', cache: false }.to_json
      elsif options[:zip].present?
        response = @client.current_weather(zip: options[:zip])
      else
        response = @client.current_weather(city: options[:city])
      end

      return response
  end
end

=begin
  client = WeatherForecast.new
  client.process(zip: "20906")
  client.process(zip: "20906", country: "US")
  client.process(city: "Silver Spring")

  data = client.process(city: "Silver Spring")

  data.main.temp_f
  data.main.temp_max_f
  data.main.temp_min_f
=end