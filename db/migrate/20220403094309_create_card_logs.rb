# frozen_string_literal: true

class CreateCardLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :card_logs do |t|
      t.integer :action_type, null: false
      t.integer :card_id, index: true, null: false
      t.text :message

      t.timestamps
    end
  end
end
