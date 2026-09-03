RSpec.describe Activity, type: :model do
  describe "validations" do
    it "is valid with a name, description, and allowed vibe" do
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

    it "is invalid with a vibe outside the allowed list" do
      activity = FactoryBot.build(:activity, vibe: "Adventurous")

      expect(activity).not_to be_valid
      expect(activity.errors[:vibe]).to include("is not included in the list")
    end
  end

  describe ".for_vibe" do
    it "returns activities matching the given vibe" do
      artsy_activity = FactoryBot.create(:activity, vibe: "Artsy")
      foodie_activity = FactoryBot.create(:activity, vibe: "Foodie")

      expect(Activity.for_vibe("Artsy")).to include(artsy_activity)
      expect(Activity.for_vibe("Artsy")).not_to include(foodie_activity)
    end
  end

  describe ".random_for_vibe" do
    it "returns the requested number of activities for the given vibe" do
      FactoryBot.create_list(:activity, 4, vibe: "Outdoorsy")
      FactoryBot.create(:activity, vibe: "Cozy")

      activities = Activity.random_for_vibe("Outdoorsy", 3)

      expect(activities.count).to eq(3)
      expect(activities).to all(have_attributes(vibe: "Outdoorsy"))
    end
  end
end