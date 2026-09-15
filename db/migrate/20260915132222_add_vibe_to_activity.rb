class AddVibeToActivity < ActiveRecord::Migration[8.1]
  def change
    add_reference :activities, :vibe, foreign_key: true
  end
end
