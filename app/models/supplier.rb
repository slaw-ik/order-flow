# frozen_string_literal: true

# == Schema Information
#
# Table name: suppliers
#
#  id         :bigint           not null, primary key
#  name       :string
#  email      :string
#  phone      :string
#  address_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Supplier < ApplicationRecord
  belongs_to :address, optional: false

  validates :name, presence: true

  delegate :full_address, to: :address
end
