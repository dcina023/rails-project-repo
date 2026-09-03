require "rails_helper"

RSpec.describe Ability, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:ability) { described_class.new(user) }

  it "allows a user to read themselves" do
    expect(ability.can?(:read, user)).to be(true)
  end

  it "allows a user to manage their own plans" do
    plan = FactoryBot.create(:plan, user: user)

    expect(ability.can?(:manage, plan)).to be(true)
  end

  it "allows a user to read activities" do
    activity = FactoryBot.create(:activity)

    expect(ability.can?(:read, activity)).to be(true)
  end

  it "allows a user to manage plan activities for their own plans" do
    plan = FactoryBot.create(:plan, user: user)
    plan_activity = FactoryBot.create(:plan_activity, plan: plan)

    expect(ability.can?(:manage, plan_activity)).to be(true)
  end

  it "does not give guests permissions" do
    guest_ability = described_class.new(nil)
    plan = FactoryBot.build(:plan)

    expect(guest_ability.can?(:manage, plan)).to be(false)
  end
end