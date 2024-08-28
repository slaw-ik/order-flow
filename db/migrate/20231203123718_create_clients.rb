# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :nickname
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone

      t.belongs_to :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
