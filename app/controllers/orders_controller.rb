class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_buffet, only: [:index, :new, :create]

  def index
    if current_user.buffet_owner?
      if @buffet
        @pending_orders = @buffet.orders.where(status: 'pending').order(created_at: :desc)
        @other_orders = @buffet.orders.where.not(status: 'pending').order(created_at: :desc)
      else
        redirect_to root_path, alert: 'Buffet not found or access denied.'
        return
      end
    elsif current_user.regular_user?
      @client_orders = current_user.orders.order(created_at: :desc)
    else
      redirect_to root_path, alert: 'Access denied.'
    end
  end


  def new
    @event_types = @buffet.event_types
    @valid_days = @event_types.first&.days_of_week&.split(',')
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
    @conflicting_orders = @order.buffet.orders.where.not(id: @order.id).where(event_date: @order.event_date)
  end


  def update
    @order = Order.find(params[:id])
    previous_status = @order.status
    if @order.update(order_params)
      if @order.status == 'confirmed' && previous_status != 'confirmed'
        @order.calculate_price
        unless @order.save
          flash[:alert] = 'Failed to update the price for the order.'
        end
      end
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :show, alert: 'Failed to update the order.'
    end
  end

  def edit_price
    @order = Order.find(params[:id])
    redirect_to(root_path, alert: 'Not authorized') unless @order.buffet == current_user.buffet
  end

  def update_price
    @order = Order.find(params[:id])
    if @order.update(order_price_params)
      redirect_to @order, notice: 'Price successfully updated.'
    else
      render :edit_price
    end
  end


  private
  def order_price_params
    params.require(:order).permit(:price)
  end

  def set_buffet
    return unless params[:buffet_id]

    @buffet = Buffet.find_by(id: params[:buffet_id])
    unless @buffet
      redirect_to root_path, alert: 'Buffet not found.'
      return
    end

    if current_user.buffet_owner? && @buffet.user != current_user
      redirect_to root_path, alert: 'Access denied.'
    end
  end


  def order_params
    params.require(:order).permit(:event_date, :guest_count, :details, :alternative_address, :event_type_id, :status)
  end

end
