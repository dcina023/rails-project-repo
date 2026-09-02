class RenamePlanInterestsToPlanActivities < ActiveRecord::Migration[7.1]
  def change
    rename_table :plan_interests, :plan_activities
  end
end
