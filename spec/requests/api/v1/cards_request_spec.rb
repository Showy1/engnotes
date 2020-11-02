require 'rails_helper'

RSpec.describe 'Api::V1::Cards', type: :request do
  describe 'GET /api/v1/cards' do
    it 'returns http success' do
      get '/api/v1/cards'
      expect(response).to have_http_status(:ok)
    end
  end
end
