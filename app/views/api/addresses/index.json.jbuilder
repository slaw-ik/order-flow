# frozen_string_literal: true

json.array! @addresses, partial: 'api/addresses/address', as: :address
