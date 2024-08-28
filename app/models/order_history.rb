# frozen_string_literal: true

# == Schema Information
#
# Table name: order_histories
#
#  id         :bigint           not null, primary key
#  order_id   :bigint           not null
#  state      :string           default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class OrderHistory < ApplicationRecord
  enum state: Order::ORDER_STATES

  belongs_to :order
end
