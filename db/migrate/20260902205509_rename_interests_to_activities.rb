class RenameInterestsToActivities < ActiveRecord::Migration[8.1]
  def change
    rename_table :interests, :activities
  end
end
