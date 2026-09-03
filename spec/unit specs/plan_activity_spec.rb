RSpec.describe PlanActivity, type: :model do
  describe "associations" do
    it "belongs to a plan" do
      association = described_class.reflect_on_association(:plan)

      expect(association.macro).to eq(:belongs_to)
    end

    it "belongs to an activity" do
      association = described_class.reflect_on_association(:activity)

      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    it "is valid with a numeric rating" do
      plan_activity = FactoryBot.build(:plan_activity, rating: 4)

      expect(plan_activity).to be_valid
    end

    it "is valid without a rating" do
      plan_activity = FactoryBot.build(:plan_activity, rating: nil)

      expect(plan_activity).to be_valid
    end

    it "is invalid with a non-numeric rating" do
      plan_activity = FactoryBot.build(:plan_activity, rating: "great")

      expect(plan_activity).not_to be_valid
      expect(plan_activity.errors[:rating]).to include("is not a number")
    end
  end
end