require 'rails_helper'

describe Weather do
  let(:model) { Weather }

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
        ]
      }

      instance = model.new(response: response)

      expect(instance.city).to     eq :city
      expect(instance.temp).to     eq :temp
      expect(instance.temp_max).to eq :temp_max
      expect(instance.temp_min).to eq :temp_min
      expect(instance.weather).to  eq :weather
    end

    it 'is able to initialize directly from attributes' do
      instance = model.new(
        city:     :city,
        temp:     :temp,
        temp_max: :temp_max,
        temp_min: :temp_min,
        weather:  :weather
      )

      expect(instance.city).to     eq :city
      expect(instance.temp).to     eq :temp
      expect(instance.temp_max).to eq :temp_max
      expect(instance.temp_min).to eq :temp_min
      expect(instance.weather).to  eq :weather
    end
  end
end
