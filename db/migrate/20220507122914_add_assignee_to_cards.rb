class AddAssigneeToCards < ActiveRecord::Migration[5.2]
  def change
    change_table :cards, bulk: true do |t|
      t.integer :assignee_id, null: true
      t.index :assignee_id
    end
  end
end
