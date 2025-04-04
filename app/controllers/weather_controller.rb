
class WeatherController < ApplicationController
  def index
  end

  def fetch
    forecast = WeatherForecast.new
    result = forecast.process(params.permit(:city, :zip))

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("weather_result", partial: "weather/result", locals: { result: result })
      end
    end
  end
end
