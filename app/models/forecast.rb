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

  def self.attributes
    ATTRIBUTES
  end

  def initialize(**args)
    args.each do |name, value|
      public_send("#{name}=", value) if respond_to?("#{name}=")
    end
  end
end
