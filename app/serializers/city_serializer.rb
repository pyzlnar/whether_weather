# Serializer for cities
class CitySerializer
  include FastJsonapi::ObjectSerializer

  set_id :open_weather_id
  attribute :name
end
