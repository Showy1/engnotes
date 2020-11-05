require 'rails_helper'

RSpec.describe 'Api::V1::Cards', type: :request do
  let(:user) { create(:user, confirmed_at: DateTime.now) }
  # ref. spec/factories/users.rb
  # sequence(:username) { |n| 'TEST_NAME#{n}' }
  # sequence(:email) { |n| 'TEST#{n}@example.com' }
  # password {'password'}

  describe 'GET /api/v1/cards' do
    it 'returns http internal server error without login' do
      get '/api/v1/cards'
      expect(response).to have_http_status(:internal_server_error)
    end

    it 'returns http success' do
      sign_in user
      get '/api/v1/cards'
      expect(response).to have_http_status(:ok)
    end
  end
end
