class EventTypesController < ApplicationController
  before_action :authenticate_user!

  def index
    @buffet = Buffet.find(params[:buffet_id])
    @event_types = @buffet.event_types
  end

  def show
    @event_type = EventType.find(params[:id])
  end

  def new
    @buffet = Buffet.find(params[:buffet_id])
    @event_type = @buffet.event_types.build
  end

  def create
    @buffet = Buffet.find(params[:buffet_id])
    @event_type = @buffet.event_types.build(event_type_params)

    if @event_type.save
      redirect_to buffet_path(@buffet), notice: "Event type created successfully."
    else
      render :new
    end
  end

  private

  def event_type_params
    params.require(:event_type).permit(:name, :description,
                                       :min_capacity, :max_capacity,
                                       :duration_minutes, :menu_text, :has_alcoholic_beverages,
                                       :has_decorations, :has_parking_service, :venue_options)
  end
end