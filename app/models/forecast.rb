# Virtual Model
# Encapsules the response of the current weather
class Forecast
  ATTRIBUTES = %i[
    city
    today_temp
    today_temp_max
    today_temp_min
    today_weather
    tomorrow_temp
    tomorrow_temp_max
    tomorrow_temp_min
    tomorrow_weather
    five_days_temp
    five_days_temp_max
    five_days_temp_min
    five_days_weather
  ].freeze

  attr_accessor(*ATTRIBUTES)

  def initialize(response: nil, **args)
    if response
      initialize_from_response(response)
    else
      initialize_from_args(args)
    end
  end

  def initialize_from_response(response)
    @city = response.dig('name')
    initialize_forecast_for_date(:today,     response)
    initialize_forecast_for_date(:tomorrow,  response.dig('list', 0))
    initialize_forecast_for_date(:five_days, response.dig('list', -1))
  end

  def initialize_forecast_for_date(prefix, info)
    %w[temp temp_max temp_min].each do |attribute|
      instance_variable_set("@#{prefix}_#{attribute}", info.dig('main', attribute))
    end
    instance_variable_set("@#{prefix}_weather", info.dig('weather', 0, 'main'))
  end

  def initialize_from_args(args)
    args.each do |name, value|
      public_send("#{name}=", value) if respond_to?("#{name}=")
    end
  end
end
