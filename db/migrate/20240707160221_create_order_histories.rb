# frozen_string_literal: true

class CreateOrderHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :order_histories do |t|
      t.references :order, null: false, foreign_key: true
      t.string :state, null: false, default: 'pending'

      t.timestamps
    end
  end
end
