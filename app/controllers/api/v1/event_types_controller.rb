class Api::V1::EventTypesController < ActionController::API
  before_action :set_buffet
  before_action :set_event_type, only: [:index, :check_availability]

  def index
    event_types = @buffet.event_types
    render json: event_types
  end


  def check_availability
    event_date = params[:event_date].to_date
    guest_count = params[:guest_count].to_i
    event_day = event_date.wday.to_s
    days_of_week = JSON.parse(@event_type.days_of_week)

    if days_of_week.include?(event_day)
      available = @event_type.available_on?(event_date, guest_count)

      if available
        estimated_price = @event_type.calculate_price(guest_count, event_date)
        if estimated_price.zero?
          render json: { available: false, error: "No price set for this day" }, status: :unprocessable_entity
        else
          render json: { available: true, estimated_price: estimated_price }
        end
      else
        render json: { available: false, error: "Event type not available on this date for the specified guest count" }, status: :unprocessable_entity
      end
    else
      render json: { available: false, error: "Event type not available on this day of the week" }, status: :unprocessable_entity
    end
  end

  private

  def set_buffet
    @buffet = Buffet.find(params[:buffet_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Buffet not found' }, status: :not_found
  end

  def set_event_type
    @event_type = @buffet.event_types.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Event type not found' }, status: :not_found
  end
end