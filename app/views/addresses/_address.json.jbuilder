# frozen_string_literal: true

json.extract! address, :id, :country, :city, :region, :street, :post_code, :building, :flat, :note, :created_at,
              :updated_at
json.url address_url(address, format: :json)
