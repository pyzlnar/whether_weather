# This controller manages forecast requests
class ForecastController < ApplicationController
  # GET /forecast
  def show
    return unless params[:id].to_s.match?(/\A\d+\z/)

    unless (result = request_forecast(params[:id]))
      flash.now[:failure] = 'Something went wrong, please try again later'
      return
    end

    @id       = params[:id]
    @forecast = Forecast.new(response: result)
  end

  private

  def request_forecast(city)
    cache = Rails.cache.read("forecast_#{city}")
    return cache if cache

    weather_result  = OpenWeather.weather(city: city)
    forecast_result = OpenWeather.forecast(city: city)

    return unless weather_result.success? && forecast_result.success?

    result = weather_result.merge(forecast_result)
    Rails.cache.write("forecast_#{city}", result, expires_in: 1.hour)
    result
  end
end
