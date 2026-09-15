class AddVibeToPlans < ActiveRecord::Migration[8.1]
  def change
    add_reference :plans, :vibe, null: true, foreign_key: true
  end
end
