require 'rails_helper'

describe Forecast do
  let(:model) { Forecast }

  context '#initialize' do
    it 'is able to initialize from a response' do
      response = {
        'name' => :city,
        'main' => {
          'temp'     => :temp,
          'temp_max' => :temp_max,
          'temp_min' => :temp_min
        },
        'weather' => [
          { 'main' => :weather }
        ],
        'list' => [
          {
            'main' => {
              'temp'     => :tomorrow_temp,
              'temp_max' => :tomorrow_temp_max,
              'temp_min' => :tomorrow_temp_min
            },
            'weather' => [
              { 'main' => :tomorrow_weather }
            ],
          },
          {
            'main' => {
              'temp'     => :five_days_temp,
              'temp_max' => :five_days_temp_max,
              'temp_min' => :five_days_temp_min
            },
            'weather' => [
              { 'main' => :five_days_weather }
            ],
          }
        ]
      }

      instance = model.new(response: response)

      expect(instance.city).to     eq :city
      expect(instance.today_temp).to     eq :temp
      expect(instance.today_temp_max).to eq :temp_max
      expect(instance.today_temp_min).to eq :temp_min
      expect(instance.today_weather).to  eq :weather

      expect(instance.tomorrow_temp).to     eq :tomorrow_temp
      expect(instance.tomorrow_temp_max).to eq :tomorrow_temp_max
      expect(instance.tomorrow_temp_min).to eq :tomorrow_temp_min
      expect(instance.tomorrow_weather).to  eq :tomorrow_weather

      expect(instance.five_days_temp).to     eq :five_days_temp
      expect(instance.five_days_temp_max).to eq :five_days_temp_max
      expect(instance.five_days_temp_min).to eq :five_days_temp_min
      expect(instance.five_days_weather).to  eq :five_days_weather
    end

    it 'is able to initialize directly from attributes' do
      instance = model.new(
        city:           :city,
        today_temp:     :today_temp,
        today_temp_max: :today_temp_max,
        today_temp_min: :today_temp_min,
        today_weather:  :today_weather
      )

      expect(instance.city).to           eq :city
      expect(instance.today_temp).to     eq :today_temp
      expect(instance.today_temp_max).to eq :today_temp_max
      expect(instance.today_temp_min).to eq :today_temp_min
      expect(instance.today_weather).to  eq :today_weather
    end
  end
end
