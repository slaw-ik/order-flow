# frozen_string_literal: true

class CreateSuppliers < ActiveRecord::Migration[7.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :email
      t.string :phone

      t.belongs_to :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
