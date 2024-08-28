# frozen_string_literal: true

json.items do
  json.array! @items, partial: 'items/item', as: :item
end

json.total @total
json.page @page
