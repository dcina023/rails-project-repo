require "rails_helper"
require "securerandom"

RSpec.describe "Users", type: :request do
  describe "GET /users/:id" do
    let(:user) do
      FactoryBot.create(
        :user,
        email: "user-spec-#{SecureRandom.hex(8)}@example.com",
        password: "password"
      )
    end

    before do
      post login_path, params: {
        email: user.email,
        password: "password"
      }

      expect(response).to redirect_to(user_path(user))
    end

    it "returns a successful response" do
      get user_path(user)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /sign_ups/new" do
    it "returns a successful response" do
      get new_sign_up_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /sign_ups" do
    it "creates a new user" do
      valid_attributes = {
        name: "Test User",
        email: "new-user@example.com",
        password: "password"
      }

      expect do
        post sign_ups_path, params: { user: valid_attributes }
      end.to change(User, :count).by(1)
    end

    it "redirects after successfully creating a new user" do
      valid_attributes = {
        name: "Testie",
        email: "testie123@example.com",
        password: "password"
      }

      post sign_ups_path, params: { user: valid_attributes }

      expect(response).to redirect_to(root_path)
    end
  end
end
