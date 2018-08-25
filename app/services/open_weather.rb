# Manages the open weather API
# https://openweathermap.org/api
module OpenWeather
  extend self

  CONFIG = {
    base: 'https://api.openweathermap.org/data/2.5',
    options: {
      appid: Rails.application.credentials.open_weather_key,
      units: :metric
    }
  }.freeze

  def config
    CONFIG
  end

  def forecast(city:)
    send_request(:forecast, id: city)
  end

  def weather(city:)
    send_request(:weather, id: city)
  end

  private

  def send_request(path, **options)
    query = config[:options].merge(options)
    HTTParty.get "#{config[:base]}/#{path}", query: query
  end
end
