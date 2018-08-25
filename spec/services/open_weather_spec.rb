require 'rails_helper'

describe OpenWeather do
  let(:service) { OpenWeather }

  context '.weather' do
    it 'returns info about the weather' do
      response = VCR.use_cassette 'open_weather_weather' do
        service.weather(city: 3530597)
      end

      expect(response['name']).to eq 'Mexico City'
      expect(response.dig('main', 'temp_min')).to_not be_nil
      expect(response.dig('main', 'temp_max')).to_not be_nil
    end
  end
end
