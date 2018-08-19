# This controller manages forecast requests
class ForecastController < ApplicationController
  # GET /forecast
  def show
    return unless params[:city].present?

    result = OpenWeather.weather(city: params[:city].strip)
    unless result.success?
      flash.now[:failure] = 'Something went wrong, please try again later'
      return
    end

    @forecast = Forecast.new(response: result)
  end
end
