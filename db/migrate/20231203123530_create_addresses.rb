# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :country, null: false
      t.string :city, null: false
      t.string :region, null: false
      t.string :street, null: false
      t.string :post_code
      t.string :building, null: false
      t.string :flat
      t.string :note

      t.timestamps
    end
  end
end
