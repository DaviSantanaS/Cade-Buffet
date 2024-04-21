class EventPricesController < ApplicationController
  before_action :set_event_type, only: [:index, :new, :create, :show]

  def index
    @event_prices = @event_type.event_prices
  end

  def new
    @event_price = @event_type.event_prices.build
  end

  def create
    @event_price = @event_type.event_prices.build(event_price_params)

    if @event_price.save
      redirect_to event_type_event_prices_path(@event_type), notice: 'Event price was successfully created.'
    else
      render :new
    end
  end

  def show
    @event_price = @event_type.event_prices.find(params[:id])
  end

  private

  def set_event_type
    @event_type = EventType.find(params[:event_type_id])
  end

  def event_price_params
    params.require(:event_price).permit(:base_price, :additional_price_per_person, :extra_hour_price)
  end
end
