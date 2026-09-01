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
  it "has many plan interests" do
      expect(plan).to have_many(:plan_interests)
      end
  it "has many interests through plan interests" do
    expect(plan).to have_many(:interests).through(:plan_interests)
  end
  end
end