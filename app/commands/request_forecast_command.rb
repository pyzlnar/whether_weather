# Command to request a forecast either from api or from cache
class RequestForecastCommand
  include AyeCommander::Command

  requires :city_id
  returns :city_id, :forecast

  def call
    validate_city_id
    set_forecast_attributes
    set_forecast
  end

  private

  def validate_city_id
    return if city_id.to_s.match?(/\A\d+\z/)
    fail!(:invalid_city_id) && abort!
  end

  def set_forecast_attributes
    @cache_key  = "#{Date.today}_forecast_#{city_id}"
    @attributes = attributes_from_cache || attributes_from_request
  end

  def attributes_from_cache
    Rails.cache.read(cache_key)
  end

  def attributes_from_request
    results = %w[weather forecast].map do |type|
      send("attributes_from_#{type}")
    end
    fail!(:fetch_forecast_failed) && abort! unless results.all?

    attributes = results.reduce(:merge).symbolize_keys
    Rails.cache.write(cache_key, attributes, expires_in: 1.day)
    attributes
  end

  def attributes_from_weather
    result = OpenWeather.weather(city: city_id)
    return unless result.success?
    attributes_for_date(:today, result).merge(city: result.dig('name'))
  end

  def attributes_from_forecast
    result = OpenWeather.forecast(city: city_id)
    return unless result.success?

    tomorrow  = attributes_for_date(:tomorrow, result.dig('list', 0))
    five_days = attributes_for_date(:five_days, result.dig('list', -1))
    tomorrow.merge(five_days)
  end

  def attributes_for_date(prefix, info)
    %w[temp temp_max temp_min].each_with_object({}) do |attribute, hash|
      hash["#{prefix}_#{attribute}"] = info.dig('main', attribute)
    end.merge("#{prefix}_weather" => info.dig('weather', 0, 'main'))
  end

  def set_forecast
    @forecast = Forecast.new(attributes)
  end
end
