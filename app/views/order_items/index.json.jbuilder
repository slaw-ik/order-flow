# frozen_string_literal: true

json.order_items do
  json.array! @order_items, partial: 'order_items/order_item', as: :order_item
end

json.total @total
json.page @page
