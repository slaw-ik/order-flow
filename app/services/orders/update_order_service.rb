# frozen_string_literal: true

module Orders
  class UpdateOrderService
    include Utils

    attr_reader :order, :params

    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      existing_items = order.order_items.pluck(:item_id)
      new_items = params[:order_items_attributes].map { |order_item| order_item[:item_id] }

      compared_items = compare_arrays(existing_items, new_items)

      puts "=================================="
      puts "items to add: #{compared_items[:new]}"
      puts "items to delete: #{compared_items[:deleted]}"
      puts "items to update: #{compared_items[:existed]}"
      puts "=================================="
    end
  end
end
