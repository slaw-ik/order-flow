# frozen_string_literal: true

json.clients do
  json.array! @clients, partial: 'api/clients/client', as: :client
end

json.total @total
json.page @page
