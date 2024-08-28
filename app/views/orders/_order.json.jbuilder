# frozen_string_literal: true

json.extract! order, :id, :user_id, :supplier_id, :client_id, :type, :state, :total, :country, :city, :region,
              :phone, :post_code, :building, :flat, :street, :note, :created_at, :updated_at

json.fullAddress order.full_address

if order.is_a? ClientOrder
  json.client do
    json.extract! order.client, :id, :first_name, :last_name, :name, :nickname, :email, :phone, :created_at, :updated_at
    json.fullAddress order.client.full_address
    json.address do
      json.extract! order.client.address, :id, :country, :city, :region, :street, :post_code, :building, :flat,
                    :created_at, :updated_at
    end
  end
else
  json.name order.supplier.name
  json.email order.supplier.email
  json.phone order.supplier.phone
end

json.orderItems order.order_items do |order_item|
  json.extract! order_item, :id, :item_id, :order_id, :count, :price, :total, :created_at, :updated_at
  json.item do
    json.extract! order_item.item, :id, :name, :stock_count, :description, :price, :created_at, :updated_at
  end
end
