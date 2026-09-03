require "rails_helper"
RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.build(:user) }

  describe "#validations" do
    it 'validates the presence of name' do
      expect(user).to validate_presence_of(:name)
    end
  end

  describe "#normalizations" do
      it 'normalizes email by stripping whitespace and downcasting' do
        user = FactoryBot.build(:user, email: "  TEST@Example.COM  ")
      
        expect(user.email).to eq("test@example.com")
    end
  end
  describe "#associations" do
    it 'has many plans' do
      expect(user).to have_many(:plans)
    end
  end
end
