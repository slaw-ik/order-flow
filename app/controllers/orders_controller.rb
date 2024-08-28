# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]
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

    render json: result, status: :ok

    # if @order.update(order_params)
    #   respond_to_success('Order was successfully updated.', :ok)
    # else
    #   respond_to_failure(@order.errors, :unprocessable_entity)
    # end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { render json: Order.all, status: :ok }
    end
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

  def respond_to_success(notice, status)
    respond_to do |format|
      format.html { redirect_to order_url(@order), notice: }
      format.json { render :show, status:, location: @order }
    end
  end

  def respond_to_failure(errors, status)
    respond_to do |format|
      format.html { render :edit, status: }
      format.json { render json: errors, status: }
    end
  end
end
