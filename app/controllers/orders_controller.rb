# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy change_state]
  skip_before_action :verify_authenticity_token

  # GET /orders or /orders.json
  def index
    @page = (params[:page] || 1).to_i
    @total = ClientOrder.count
    @client_orders = ClientOrder.includes(client: [:address], order_items: [:item])
                                .order(created_at: :desc)
                                .page(@page)
  end

  # GET /orders/1 or /orders/1.json
  def show; end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit; end

  def create
    @order = Orders::CreateOrderService.new(order_params).call

    render :show, status: :created, location: @order
  rescue ActiveRecord::RecordInvalid => e
    render json: e.record.errors, status: :unprocessable_entity
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    result = Orders::UpdateOrderService.new(@order, order_params).call

    render :show, status: :ok, locals: { order: result }
  rescue ActiveRecord::RecordInvalid => e
    render json: e.record.errors, status: :unprocessable_entity
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { render json: Order.all, status: :ok }
    end
  end

  def change_state
    state = params[:state]

    if state.blank? || Order::ORDER_STATES.values.exclude?(state)
      render json: { error: 'Invalid state' }, status: :unprocessable_entity
      return
    end

    @order.state = state

    case state
    when Order::ORDER_STATES[:packed]
      @order.packed_at = Time.zone.now
    when Order::ORDER_STATES[:shipped]
      @order.shipped_at = Time.zone.now
    when Order::ORDER_STATES[:cancelled]
      @order.cancelled_at = Time.zone.now
    end

    @order.save

    render :show, status: :ok, locals: { order: @order }
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      :id, :user_id, :supplier_id, :client_id, :type, :state, :total, :country, :city, :region,
      :street, :post_code, :building, :flat, :note, :phone,
      order_items_attributes: %i[id item_id count price]
    )
  end
end
