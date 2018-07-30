require 'rails_helper'

describe WeatherController do
  context 'GET show' do
    it 'just renders with no params' do
      expect(OpenWeather).to_not receive(:weather)
      expect(Weather).to_not receive(:new)

      get :show
      expect(response).to render_template :show
    end

    it 'returns a weather if city param is received' do
      result  = double(success?: true)
      weather = double
      expect(OpenWeather).to receive(:weather).and_return(result)
      expect(Weather).to receive(:new).and_return(weather)

      get :show, params: { city: :london }
      expect(assigns(:weather)).to eq weather
    end

    it 'renders with a flash if open weather fails to load' do
      result = double(success?: false)
      expect(OpenWeather).to receive(:weather).and_return(result)
      expect(Weather).to_not receive(:new)

      get :show, params: { city: :london }
      expect(flash[:failure]).to_not be_empty
    end
  end
end
