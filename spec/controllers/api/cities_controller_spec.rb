require 'rails_helper'

describe Api::CitiesController do
  context 'GET index' do
    it 'returns unprocessable_entity if no city is provided' do
      get :index

      expected = {}.to_json

      expect(response.status).to eq 422
      expect(response.body).to eq expected
    end
  end
end
