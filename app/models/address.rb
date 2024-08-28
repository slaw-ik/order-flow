# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  country    :string           not null
#  city       :string           not null
#  region     :string           not null
#  street     :string           not null
#  post_code  :string
#  building   :string           not null
#  flat       :string
#  note       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Address < ApplicationRecord
  has_one :client, dependent: :destroy
  has_one :supplier, dependent: :destroy

  def full_address
    [street, building, flat, city, region, post_code, country].filter(&:present?).join(', ')
  end
end
