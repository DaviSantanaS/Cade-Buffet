class Api::V1::EventTypesController < ActionController::API
  before_action :set_buffet

  def index
    event_types = @buffet.event_types
    render json: event_types
  end

  private

  def set_buffet
    @buffet = Buffet.find(params[:buffet_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Buffet not found' }, status: :not_found
  end
end