require 'rails_helper'

RSpec.describe 'Cards', type: :request do
  let(:user) { create(:user, confirmed_at: DateTime.now) }
  # ref. spec/factories/users.rb
  # sequence(:username) { |n| 'TEST_NAME#{n}' }
  # sequence(:email) { |n| 'TEST#{n}@example.com' }
  # password {'password'}

  describe 'GET /' do
    it 'returns http redirect without login' do
      get '/'
      expect(response).to have_http_status(:found)
    end

    it 'returns http success with login' do
      sign_in user
      get '/'
      expect(response).to have_http_status(:ok)
    end
  end
end
