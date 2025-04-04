require 'test_helper'
require 'minitest/mock'

class WeatherForecastTest < ActiveSupport::TestCase
  def setup
    @mock_client = Minitest::Mock.new
  end

  test "returns error if no city or zip provided" do
    forecast = WeatherForecast.new(@mock_client)

    response = forecast.process
    parsed = JSON.parse(response)

    assert_nil parsed["data"]
    assert_equal 'Please pass in a city OR zip.', parsed["error"]
    refute parsed["cache"]
  end

  test "calls current_weather with zip when zip is provided" do
    @mock_client.expect :current_weather, { "weather" => "sunny" }, [{ zip: "20906" }]
    forecast = WeatherForecast.new(@mock_client)

    result = forecast.process(zip: "20906")
    assert_equal({ "weather" => "sunny" }, result)

    @mock_client.verify
  end

  test "calls current_weather with city when city is provided" do
    @mock_client.expect :current_weather, { "weather" => "cloudy" }, [{ city: "Silver Spring" }]
    forecast = WeatherForecast.new(@mock_client)

    result = forecast.process(city: "Silver Spring")
    assert_equal({ "weather" => "cloudy" }, result)

    @mock_client.verify
  end
end
