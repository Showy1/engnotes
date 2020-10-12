require 'rails_helper'

RSpec.describe "Api::V1::Cards", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/cards/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/cards/show"
      expect(response).to have_http_status(:success)
    end
  end

end
