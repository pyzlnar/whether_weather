# Factories for cities
FactoryBot.define do
  factory :city do
    factory :mexico do
      name            { 'Mexico City' }
      open_weather_id { 1 }
    end

    factory :hermosillo do
      name            { 'Hermosillo' }
      open_weather_id { 2 }
    end

    factory :chihuahua do
      name            { 'Chihuahua' }
      open_weather_id { 3 }
    end
  end
end
