# frozen_string_literal: true

json.array! @suppliers, partial: 'api/suppliers/supplier', as: :supplier
