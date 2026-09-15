class CreateVibes < ActiveRecord::Migration[8.1]
  def change
    create_table :vibes do |t|
      t.string :title
      t.text :caption

      t.timestamps
    end
  end
end
