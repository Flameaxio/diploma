class CreateWebhooks < ActiveRecord::Migration[5.2]
  def change
    create_table :webhooks do |t|
      t.text :body, null: false
      t.string :url, null: false
      t.integer :column_id, null: false

      t.timestamps
    end
  end
end
