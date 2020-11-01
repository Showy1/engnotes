require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users/sign_in' do
    it 'returns http success' do
      get '/users/sign_in'
      expect(response).to have_http_status(200)
    end
  end
end
