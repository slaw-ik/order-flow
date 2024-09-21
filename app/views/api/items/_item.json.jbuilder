# frozen_string_literal: true

json.extract! item, :id, :name, :description, :stock_count, :price, :created_at, :updated_at

json.order_items do
  json.array! item.order_items.last(5) do |order_item|
    json.extract! order_item, :id, :order_id, :count, :price, :total, :created_at, :updated_at
  end
end
