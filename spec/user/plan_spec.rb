require 'rails_helper'
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
end