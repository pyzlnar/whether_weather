require 'rails_helper'

describe ForecastController do
  context 'GET show' do
    let(:command) { RequestForecastCommand }

    it 'just renders with no params' do
      expect(command).to_not receive(:call)

      get :show
      expect(response).to render_template :show
    end

    it 'assigns a forecast on success' do
      city_id  = 2643743
      forecast = Forecast.new
      result   = double(status: :success, city_id: city_id, forecast: forecast)

      expect(command).to receive(:call).and_return(result)

      get :show, params: { id: city_id, city: :london }

      expect(assigns(:id)).to       eq city_id
      expect(assigns(:forecast)).to eq forecast
    end

    it 'renders a flash on failure' do
      result = double(status: :invalid_city_id)
      expect(command).to receive(:call).and_return(result)

      get :show, params: { id: 2643743, city: :london }
      expect(flash[:failure]).to_not be_empty
    end
  end
end
