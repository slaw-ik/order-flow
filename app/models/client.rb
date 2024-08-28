# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  nickname   :string
#  first_name :string
#  last_name  :string
#  email      :string
#  phone      :string
#  address_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Client < ApplicationRecord
  belongs_to :address, optional: false
  accepts_nested_attributes_for :address

  def self.search(search)
    if search.present?
      where('first_name ILIKE ? OR last_name ILIKE ? OR email LIKE ? OR phone LIKE ?', "%#{search}%", "%#{search}%",
            "%#{search}%", "%#{search}%")
    else
      []
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  delegate :full_address, to: :address
end
