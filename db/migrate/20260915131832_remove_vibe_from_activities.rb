class RemoveVibeFromActivities < ActiveRecord::Migration[8.1]
  def change
    remove_column :activities, :vibe, :string
  end
end
