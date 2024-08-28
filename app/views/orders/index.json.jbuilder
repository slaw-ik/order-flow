# frozen_string_literal: true

json.orders do
  json.array! @client_orders, partial: 'orders/order', as: :order
end
json.total @total
json.page @page
