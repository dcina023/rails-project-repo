class AddDetailsToPlanInterests < ActiveRecord::Migration[8.1]
  def change
    add_column :plan_interests, :notes, :string
    add_column :plan_interests, :rating, :integer
  end
end
