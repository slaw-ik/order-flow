# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  supplier_id :bigint
#  client_id   :bigint
#  type        :string           not null
#  state       :string           default("pending"), not null
#  total       :decimal(10, 2)   default(0.0), not null
#  country     :string
#  city        :string
#  region      :string
#  street      :string
#  post_code   :string
#  building    :string
#  flat        :string
#  note        :string
#  phone       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ClientOrder < Order
end
