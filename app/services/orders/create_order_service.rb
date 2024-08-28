# frozen_string_literal: true

module Orders
  class CreateOrderService
    attr_reader :order_params

    def initialize(order_params)
      @order_params = order_params
    end

    def call
      @order = build_order

      Order.transaction do
        @order.save!
        create_order_items
      end

      @order
    end

    private

    def build_order
      order_class = determine_order_class
      order_class.new(order_params.except(:order_items_attributes, :id)).tap do |order|
        # order.user_id = current_user.id
        order.user_id = 1
        order.state = Order::ORDER_STATES[:pending]
        order.total = 0
      end
    end

    def create_order_items
      order_params[:order_items_attributes].each do |item|
        @order.order_items.create!(item.except(:id))
      end
    end

    def determine_order_class
      if order_params[:client_id].present?
        ClientOrder
      elsif order_params[:supplier_id].present?
        SupplierOrder
      else
        raise ArgumentError, 'Order must have a client_id or supplier_id'
      end
    end
  end
end
