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
      Order.transaction do
        update_order_attributes
        update_order_items
        order.save!
      end

      order
    end

    private

    def update_order_attributes
      order.assign_attributes(order_params)
    end

    def update_order_items
      existing_items = order.order_items.index_by(&:item_id)
      new_items_params = params[:order_items_attributes].index_by { |item| item[:item_id] }

      items_to_delete = existing_items.keys - new_items_params.keys
      items_to_create = new_items_params.keys - existing_items.keys
      items_to_update = existing_items.keys & new_items_params.keys

      destroy_order_items(items_to_delete)
      update_existing_items(existing_items, new_items_params, items_to_update)
      create_new_items(new_items_params, items_to_create)
    end

    def destroy_order_items(ids)
      order.order_items.where(item_id: ids).destroy_all
    end

    def update_existing_items(existing_items, new_items_params, ids)
      ids.each do |item_id|
        order_item = existing_items[item_id]
        order_item.update!(new_items_params[item_id].except(:id))
      end
    end

    def create_new_items(new_items_params, ids)
      ids.each do |item_id|
        order.order_items.create!(new_items_params[item_id])
      end
    end

    def order_params
      params.except(:order_items_attributes, :id)
    end
  end
end
