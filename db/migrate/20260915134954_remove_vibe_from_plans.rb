class RemoveVibeFromPlans < ActiveRecord::Migration[8.1]
  def change
    remove_column :plans, :vibe, :string
  end
end
