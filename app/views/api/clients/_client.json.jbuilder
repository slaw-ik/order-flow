# frozen_string_literal: true

json.extract! client, :id, :nickname, :first_name, :last_name, :email, :phone, :address_id, :created_at, :updated_at

json.address do
  json.extract! client.address,
                :id, :country, :city, :region, :street, :post_code, :building, :flat, :note, :created_at,
                :updated_at, :full_address
end
