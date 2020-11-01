require 'rails_helper'

RSpec.describe 'Cards', type: :request do
  before do
    # @user = build(:user)
    # ref. spec/factories/users.rb
    # sequence(:username) { |n| 'TEST_NAME#{n}' }
    # sequence(:email) { |n| 'TEST#{n}@example.com' }
    # password {'password'}
  end

  describe 'GET /' do
    it 'returns http success' do
      pending
      sign_in @user
      get '/'
      expect(response).to have_http_status(302)
    end
  end
end
