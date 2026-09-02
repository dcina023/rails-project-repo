class RenameInterestIdToActivityIdOnPlanActivities < ActiveRecord::Migration[8.1]
  def change
    rename_column :plan_activities, :interest_id, :activity_id
  end
end
