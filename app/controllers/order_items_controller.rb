# frozen_string_literal: true

class OrderItemsController < ApplicationController
  # GET /items/:id/movements
  # GET /items/:id/movements.json
  def index
    @page = (params[:page] || 1).to_i
    @all_order_items = OrderItem.where(item_id: params[:id])
    @total = @all_order_items.count
    @order_items = @all_order_items.page(@page)
  end
end
