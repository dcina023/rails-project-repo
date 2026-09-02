require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "#show" do
    it "returns a successful response" do
      post sessions_path, params: {
        login: {
          email: user.email,
          password: "password"
        }
      }

      get user_path(user)

      expect(response).to have_http_status(:ok)
    end
  end
end

## - remember - this is considered a full integration test, it runs through the whole Rails stack, executing routing, controller hooks, database queries, and view rendering.

## You could separately test views and routing.