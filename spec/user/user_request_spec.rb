require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "#show" do
    it "returns a successful response" do
      post login_path, params: {
          email: user.email,
          password: "password"
        }

      get user_path(user)

      expect(response).to have_http_status(:ok)
    end
  end
  describe "new" do
    it "returns a successful response" do
     get new_sign_up_path

     expect(response).to have_http_status(:ok)
    end
  end
  describe "#create" do
  it "creates a new user" do
    valid_attributes = {
      name: "Test User",
      email: "test@example.com",
      password: "password"
    }

    expect do
      post sign_ups_path, params: { user: valid_attributes }
    end.to change(User, :count).by(1)
  end

  it "redirects after successfully creating a new user" do
    valid_attributes = {
      name: "testie",
      email: "testie123@example.com",
      password: "password"
    }
    post sign_ups_path, params: { user: valid_attributes }
    puts response.body

    expect(response).to redirect_to(root_path)
  end
  end
end
