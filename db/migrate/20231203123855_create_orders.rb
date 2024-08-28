# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :supplier, null: true, foreign_key: true
      t.belongs_to :client, null: true, foreign_key: true

      t.string :type, null: false
      t.string :state, null: false, default: 'pending'
      t.decimal :total, precision: 10, scale: 2, default: 0.0, null: false
      t.string :country
      t.string :city
      t.string :region
      t.string :street
      t.string :post_code
      t.string :building
      t.string :flat
      t.string :note
      t.string :phone

      t.timestamps
    end
  end
end
