class CreateColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :columns do |t|
      t.string :name, null: false
      t.belongs_to :workspace

      t.timestamps
    end
  end
end
