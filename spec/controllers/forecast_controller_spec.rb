require 'rails_helper'

describe ForecastController do
  context 'GET show' do
    it 'just renders with no params' do
      expect(OpenWeather).to_not receive(:weather)
      expect(Forecast).to_not receive(:new)

      get :show
      expect(response).to render_template :show
    end

    it 'returns a weather if city param is received' do
      result   = double(success?: true, merge: double)
      forecast = double
      expect(OpenWeather).to receive(:weather).and_return(result)
      expect(OpenWeather).to receive(:forecast).and_return(result)
      expect(Forecast).to receive(:new).and_return(forecast)

      get :show, params: { id: 2643743, city: :london }
      expect(assigns(:forecast)).to eq forecast
    end

    it 'renders with a flash if open weather fails to load' do
      result = double(success?: false)
      expect(OpenWeather).to receive(:weather).and_return(result)
      expect(OpenWeather).to receive(:forecast).and_return(result)
      expect(Forecast).to_not receive(:new)

      get :show, params: { id: 2643743, city: :london }
      expect(flash[:failure]).to_not be_empty
    end
  end
end
