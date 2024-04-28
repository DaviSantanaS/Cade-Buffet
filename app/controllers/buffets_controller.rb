class BuffetsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:show, :search]
  before_action :set_buffet, only: [:show, :edit, :update]
  before_action :verify_buffet_owner, only: [:edit, :update]


  def index
    @buffets = Buffet.all
  end

  def show
    @event_types = @buffet.event_types.includes(:event_prices)
  end

  def new
    @buffet = Buffet.new
  end

  def create
    @buffet = Buffet.create(buffet_params.merge(user_id: current_user.id))
    if @buffet.save
      redirect_to @buffet, notice: "Buffet created successfully."
    else
      flash.now[:alert] = "Error creating buffet."
      render :new
    end
  end

  def edit; end

  def update
    if @buffet.update(buffet_params)
      redirect_to @buffet, notice: "Buffet updated successfully."
    else
      flash.now[:alert] = "Error updating buffet."
      render :edit
    end
  end

  def search
    query = params[:query]
    @buffets = Buffet.joins(:event_types).
      where("buffets.name LIKE ? OR buffets.city LIKE ? OR event_types.name LIKE ?",
      "%#{query}%", "%#{query}%", "%#{query}%").order(:name).distinct
  end

  private

  def set_buffet
    @buffet = Buffet.find(params[:id])
  end

  def verify_buffet_owner
    redirect_to root_path, alert: "Only buffet owners can perform this action" unless current_user.actual_buffet_owner?(@buffet)
  end

  def buffet_params
    params.require(:buffet).permit(:name, :company_name, :cnpj, :phone, :contact_email,
                                   :address, :district, :state, :city, :zip_code, :description, :payment_methods)
  end
end
