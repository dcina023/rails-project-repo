class AddVibeToActivities < ActiveRecord::Migration[8.1]
  def change
    add_column :activities, :vibe, :string
  end
end
