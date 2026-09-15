# frozen_string_literal: true
class PlanFormComponent < ViewComponent::Base
  def initialize(user:, plan:, vibes:)
    super()
    @user = user
    @plan = plan
    @vibes = vibes
  end

private

  def submit_label
    @plan.persisted? ? "Update plan" : "Generate"
  end
end
