require "rails_helper"

RSpec.describe "Plans", type: :request do
  let(:user) { FactoryBot.create(:user, password: "password") }
  let(:plan) { FactoryBot.create(:plan, user: user) }

  before do
    post login_path, params: {
      email: user.email,
      password: "password"
    }
  end

  describe "GET /users/:user_id/plans/:id" do
    it "returns a successful response" do
      get user_plan_path(user, plan)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /users/:user_id/plans/new" do
    it "returns a successful response" do
      get new_user_plan_path(user)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /users/:user_id/plans" do
    let(:valid_attributes) do
      {
        title: "Test Plan Title",
        location: "Minneapolis, MN",
        vibe: "Artsy",
        budget: 40.0
      }
    end

    it "creates a new plan" do
      expect do
        post user_plans_path(user), params: { plan: valid_attributes }
      end.to change(Plan, :count).by(1)
    end
  end

  describe "GET /users/:user_id/plans/:id/edit" do
    it "returns a successful response" do
      get edit_user_plan_path(user, plan)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /users/:user_id/plans/:id" do
    it "redirects to the updated plan" do
      patch user_plan_path(user, plan), params: {
        plan: { title: "Updated Title" }
      }

      expect(response).to redirect_to(user_plan_path(user, plan))
    end
  end

  describe "DELETE /users/:user_id/plans/:id" do
    it "deletes an existing plan" do
      plan

      expect do
        delete user_plan_path(user, plan)
      end.to change(Plan, :count).by(-1)
    end

    it "redirects to the user's show page" do
      delete user_plan_path(user, plan)

      expect(response).to redirect_to(user_path(user))
    end
  end
end