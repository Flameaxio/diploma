class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :scoped_id, null: false
      t.belongs_to :workspace

      t.timestamps
    end
  end
end
