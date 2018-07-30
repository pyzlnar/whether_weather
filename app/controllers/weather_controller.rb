# This controller manages weather requests
class WeatherController < ApplicationController
  # GET /weather
  def show
    return unless params[:city].present?

    result = OpenWeather.weather(city: params[:city].strip)
    unless result.success?
      flash.now[:failure] = 'Something went wrong, please try again later'
      return
    end

    @weather = Weather.new(response: result)
  end
end
