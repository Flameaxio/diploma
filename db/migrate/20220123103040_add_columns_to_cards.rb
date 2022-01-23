class AddColumnsToCards < ActiveRecord::Migration[5.2]
  def change
    change_table :cards, bulk: true do |t|
      t.integer :column_id, null: false
      t.index :column_id
    end
  end
end
