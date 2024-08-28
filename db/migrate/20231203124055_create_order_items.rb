# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.belongs_to :item, null: false, foreign_key: true
      t.belongs_to :order, null: false, foreign_key: true

      t.integer :count, default: 0, null: false
      t.decimal :price, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal :total, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
