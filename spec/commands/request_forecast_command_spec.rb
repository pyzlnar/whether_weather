require 'rails_helper'

describe RequestForecastCommand do
  let(:command) { RequestForecastCommand }
  let(:params)  { { city_id: 3530597 } }

  context '#call' do
    it 'is able to succeed when requesting' do
      result = VCR.use_cassette 'open_weather_weather' do
        VCR.use_cassette 'open_weather_forecast' do
          command.call(params)
        end
      end

      forecast = result.forecast
      expect(result.status).to eq :success
      expect(forecast).to be_a Forecast
      Forecast.attributes.each do |attribute|
        expect(forecast.public_send(attribute)).to_not be_nil
      end
    end

    it 'is able to succeed when reading from cache' do
      allow(Rails.cache).to receive(:read).and_return(city: 'London')
      expect(OpenWeather).to_not receive(:weather)
      expect(OpenWeather).to_not receive(:forecast)

      result = command.call(params)

      expect(result.status).to eq :success
      expect(result.forecast.city).to eq 'London'
    end

    it 'fails if the city id is not valid' do
      result = command.call(city_id: '')
      expect(result.status).to eq :invalid_city_id
    end

    it 'fails if one or more of the requests fails' do
      allow(OpenWeather).to receive(:forecast).and_return(double(success?: false))
      result = VCR.use_cassette 'open_weather_weather' do
        command.call(params)
      end

      expect(result.status).to eq :fetch_forecast_failed
    end
  end
end
