require "rails_helper"
RSpec.describe Plan, type: :model do
  subject(:plan) { FactoryBot.build(:plan) }

  describe "#validations" do
   it "validates the presence of title" do
      expect(plan).to validate_presence_of(:title)
    end

    it "validates the presence of location" do
      expect(plan).to validate_presence_of(:location)
    end
  end
  describe '#associations' do
  it "belongs to a user" do
      expect(plan).to belong_to(:user)
    end
  it "has many plan activities" do
      expect(plan).to have_many(:plan_activities)
      end
  it "has many activities through plan activities" do
    expect(plan).to have_many(:activities).through(:plan_activities)
  end
  end

  describe "associations" do
    it "belongs to a vibe" do
      expect(plan).to belong_to(:vibe)
    end
  end

  describe "validations" do
    it "is valid with a vibe" do
      plan = FactoryBot.build(:plan)

      expect(plan).to be_valid
    end

    it "is invalid without a vibe" do
      plan = FactoryBot.build(:plan, vibe: nil)

      expect(plan).not_to be_valid
      expect(plan.errors[:vibe]).to include("must exist")
    end
  end

  describe "#assign_random_activities" do
    let(:vibe) { FactoryBot.create(:vibe, title: "Outdoorsy") }
    let(:plan) { FactoryBot.create(:plan, vibe: vibe) }

    let(:activities) do
      [
        FactoryBot.create(:activity, vibe: vibe),
        FactoryBot.create(:activity, vibe: vibe),
        FactoryBot.create(:activity, vibe: vibe)
      ]
    end

    before do
      allow(vibe).to receive(:random_activities)
        .with(3)
        .and_return([])
      plan
      RSpec::Mocks.space.proxy_for(vibe).reset

      allow(vibe).to receive(:random_activities)
        .with(3)
        .and_return(activities)
    end

    it "fetches random activities for the plan vibe" do
      plan.assign_random_activities

      expect(vibe).to have_received(:random_activities).with(3)
    end

    it "creates plan activity records for the returned activities" do
      expect do
        plan.assign_random_activities
      end.to change(PlanActivity, :count).by(3)
    end

    it "associates the selected activities with the plan" do
      plan.assign_random_activities

      expect(plan.activities).to match_array(activities)
    end

    it "adds default notes to each plan activity" do
      plan.assign_random_activities

      expect(plan.plan_activities.pluck(:notes)).to all(eq("Auto-selected for this plan."))
    end

    it "adds a rating between 1 and 5 to each plan activity" do
      plan.assign_random_activities

      ratings = plan.plan_activities.pluck(:rating)

      expect(ratings).to all(be_between(1, 5).inclusive)
    end

    it "uses the provided activity count" do
      allow(vibe).to receive(:random_activities)
        .with(2)
        .and_return(activities.first(2))

      plan.assign_random_activities(2)

      expect(vibe).to have_received(:random_activities).with(2)
      expect(plan.plan_activities.count).to eq(2)
    end
  end
end