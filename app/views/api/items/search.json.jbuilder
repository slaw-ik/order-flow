# frozen_string_literal: true

json.items do
  json.array! @items, partial: 'api/items/search_item', as: :item
end

json.total @total
json.page @page
