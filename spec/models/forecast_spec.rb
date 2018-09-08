require 'rails_helper'

describe Forecast do
  let(:model) { Forecast }

  context '.attributes' do
    it 'returns the ATTRIBUTES constant' do
      expect(model.attributes).to eq model::ATTRIBUTES
    end
  end

  context '#initialize' do
    it 'is able to initialize directly from attributes' do
      instance = model.new(
        city:               :city,
        today_temp:         :today_temp,
        today_temp_max:     :today_temp_max,
        today_temp_min:     :today_temp_min,
        today_weather:      :today_weather,
        tomorrow_temp:      :tomorrow_temp,
        tomorrow_temp_max:  :tomorrow_temp_max,
        tomorrow_temp_min:  :tomorrow_temp_min,
        tomorrow_weather:   :tomorrow_weather,
        five_days_temp:     :five_days_temp,
        five_days_temp_max: :five_days_temp_max,
        five_days_temp_min: :five_days_temp_min,
        five_days_weather:  :five_days_weather
      )

      expect(instance.city).to           eq :city
      expect(instance.today_temp).to     eq :today_temp
      expect(instance.today_temp_max).to eq :today_temp_max
      expect(instance.today_temp_min).to eq :today_temp_min
      expect(instance.today_weather).to  eq :today_weather

      expect(instance.tomorrow_temp).to     eq :tomorrow_temp
      expect(instance.tomorrow_temp_max).to eq :tomorrow_temp_max
      expect(instance.tomorrow_temp_min).to eq :tomorrow_temp_min
      expect(instance.tomorrow_weather).to  eq :tomorrow_weather

      expect(instance.five_days_temp).to     eq :five_days_temp
      expect(instance.five_days_temp_max).to eq :five_days_temp_max
      expect(instance.five_days_temp_min).to eq :five_days_temp_min
      expect(instance.five_days_weather).to  eq :five_days_weather
    end
  end
end
