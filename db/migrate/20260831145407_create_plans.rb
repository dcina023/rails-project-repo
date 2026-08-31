class CreatePlans < ActiveRecord::Migration[8.1]
  def change
    create_table :plans do |t|
      t.string :title
      t.string :location
      t.float :budget
      t.string :vibe
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
