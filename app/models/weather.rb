# Virtual Model
# Encapsules the response of the current weather
class Weather
  ATTRIBUTES = %i[
    city
    temp
    temp_max
    temp_min
    weather
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
    @city     = response.dig('name')
    @temp     = response.dig('main', 'temp')
    @temp_max = response.dig('main', 'temp_max')
    @temp_min = response.dig('main', 'temp_min')
    @weather  = response.dig('weather', 0, 'main')
  end

  def initialize_from_args(args)
    args.each do |name, value|
      public_send("#{name}=", value) if respond_to?("#{name}=")
    end
  end
end
