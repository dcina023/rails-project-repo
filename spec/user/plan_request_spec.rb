require "rails_helper"

RSpec.describe "Plans", type: :request do
  let(:plan) { FactoryBot.create(:plan) }

  before do
   post sessions_path, params: {
    login: {
    email: plan.user.email,
    password: "password"
  }
}
end
  describe "#show" do
    it "returns a successful response" do
      get user_plan_path(plan.user, plan)

      expect(response).to have_http_status(:ok)
    end
  end
end