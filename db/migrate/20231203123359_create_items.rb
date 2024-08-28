# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :description
      t.integer :stock_count, default: 0, null: false
      t.decimal :price, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
