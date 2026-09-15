require "rails_helper"

RSpec.describe Activity, type: :model do
  describe "validations" do
    it "is valid with a name, description, and vibe" do
      activity = FactoryBot.build(:activity)

      expect(activity).to be_valid
    end

    it "is invalid without a name" do
      activity = FactoryBot.build(:activity, name: nil)

      expect(activity).not_to be_valid
    end

    it "is invalid without a description" do
      activity = FactoryBot.build(:activity, description: nil)

      expect(activity).not_to be_valid
    end

    it "is invalid without a vibe" do
      activity = FactoryBot.build(:activity, vibe: nil)

      expect(activity).not_to be_valid
      expect(activity.errors[:vibe]).to include("must exist")
    end
  end

  describe "associations" do
    it "belongs to a vibe" do
      expect(FactoryBot.build(:activity)).to belong_to(:vibe)
    end
  end
end