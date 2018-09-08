# This controller manages forecast requests
class ForecastController < ApplicationController
  # GET /forecast
  def show
    return unless params[:id].present?

    result = RequestForecastCommand.call(city_id: params[:id])
    case result.status
    when :success
      @id       = result.city_id
      @forecast = result.forecast
    when :invalid_city_id
      flash.now[:failure] = 'Invalid city id'
    when :fetch_forecast_failed
      flash.now[:failure] = 'Failed to retrieve forecast, please try again later'
    else
      flash.now[:failure] = 'Something went wrong, please try again later'
    end
  end
end
