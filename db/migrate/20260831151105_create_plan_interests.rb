class CreatePlanInterests < ActiveRecord::Migration[8.1]
  def change
    create_table :plan_interests do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :interest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
