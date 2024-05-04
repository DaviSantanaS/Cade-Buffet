class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_buffet, only: [:new, :create]

  def index
    @orders = current_user.orders
  end

  def new
    @event_types = @buffet.event_types
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.buffet = @buffet
    if @order.save
      redirect_to order_path(@order), notice: 'Order was successfully created.'
    else
      @event_types = @buffet.event_types
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def set_buffet
    @buffet = Buffet.find(params[:buffet_id])
  end

  def order_params
    params.require(:order).permit(:event_date, :guest_count, :details, :alternative_address, :event_type_id)
  end
end
