class EventTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event_type, only: [:show, :add_photo]

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
    @event_type.days_of_week ||= []
  end

  def create
    event_type_params[:days_of_week] = event_type_params[:days_of_week].join(',') if event_type_params[:days_of_week].is_a?(Array)
    @buffet = Buffet.find(params[:buffet_id])
    @event_type = @buffet.event_types.build(event_type_params)

    if @event_type.save
      redirect_to buffet_path(@buffet), notice: I18n.t('controllers.event_types.created')
    else
      render :new
    end
  end

  def days
    event_type = EventType.find(params[:id])
    days_of_week = event_type.days_of_week || []

    render json: { days: days_of_week }
  end

  def add_photo
    if params.dig(:event_type, :photo)
      photo = @event_type.photos.new(image: params.dig(:event_type, :photo), author: current_user.name, published_at: Time.now)
      if photo.save
        redirect_to @event_type, notice: I18n.t('controllers.event_types.photo_added')
      else
        redirect_to @event_type, alert: I18n.t('controllers.event_types.photo_add_failed') + ' ' + photo.errors.full_messages.to_sentence
      end
    else
      redirect_to @event_type, alert: I18n.t('controllers.event_types.photo_not_provided')
    end
  end

  private

  def event_type_params
    params.require(:event_type).permit(:name, :description,
                                       :min_capacity, :max_capacity,
                                       :duration_minutes, :menu_text, :has_alcoholic_beverages,
                                       :has_decorations, :has_parking_service, :venue_options, days_of_week: []) #add photos: [] later
  end

  def photo_params
    params.require(:photo).permit(:image, :author, :published_at)
  end

  def set_event_type
    @event_type = EventType.find(params[:id])
  end
end
