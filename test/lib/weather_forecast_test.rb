require "test_helper"
require "minitest/mock"

class WeatherForecastTest < ActiveSupport::TestCase
  def setup
    Rails.cache.clear
    @mock_client = Minitest::Mock.new
  end

  test "returns error if no city or zip provided" do
    forecast = WeatherForecast.new(@mock_client)

    response = forecast.process

    assert_nil response[:data]
    assert_equal "Please pass in a city OR zip.", response[:error]
    refute response[:cache]
  end

  test "calls current_weather with zip when zip is provided" do
    @mock_client.expect :current_weather, { "weather" => "sunny" }, [ { zip: "20906" } ]
    forecast = WeatherForecast.new(@mock_client)

    result = forecast.process(zip: "20906")
    assert_equal({ "weather" => "sunny" }, result[:data])

    @mock_client.verify
  end

  test "calls current_weather with city when city is provided" do
    @mock_client.expect :current_weather, { "weather" => "cloudy" }, [ { city: "Silver Spring" } ]
    forecast = WeatherForecast.new(@mock_client)

    result = forecast.process(city: "Silver Spring")
    assert_equal({ "weather" => "cloudy" }, result[:data])

    @mock_client.verify
  end

  test "caches the response for a zip code" do
    sample_response = { "main" => { "temp" => 70, "temp_max" => 75, "temp_min" => 65 } }

    # Mock should be called only once
    @mock_client.expect :current_weather, sample_response, [ { zip: "12345" } ]

    forecast = WeatherForecast.new(@mock_client)

    result1 = forecast.process(zip: "12345")
    assert_equal sample_response, result1[:data]
    assert_equal false, result1[:cache]

    # Now create a second forecast, simulating a later request
    # We'll use a dummy client that should NOT be called if caching works
    dummy_client = Minitest::Mock.new
    forecast2 = WeatherForecast.new(dummy_client)

    result2 = forecast2.process(zip: "12345")
    assert_equal sample_response, result2[:data]
    assert_equal true, result2[:cache]
  end
end
