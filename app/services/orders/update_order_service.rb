# frozen_string_literal: true

module Orders
  class UpdateOrderService
    attr_reader :order, :params

    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      existing_items = order.order_items.pluck(:item_id)
      new_items = params[:order_items_attributes].map { |order_item| order_item[:item_id] }

      puts "=================================="
      puts "existing: #{existing_items} | new: #{new_items}"
      puts "=================================="
    end
  end
end
