class Api::V1::BuffetsController < ActionController::API
  before_action :set_buffet, only: [:show]

  def show
    render json: @buffet.as_json(only: [
      :id, :name, :phone, :contact_email, :address, :district,
      :state, :city, :description, :payment_methods, :zip_code
    ])
  end

  def index
    if params[:search]
      @buffets = Buffet.where('name LIKE ?', "%#{params[:search]}%")
    else
      @buffets = Buffet.all
    end
    render json: @buffets.as_json(only: [
      :id, :name, :phone, :contact_email, :address, :district,
      :state, :city, :description, :payment_methods, :zip_code
    ])
  end

  private

  def set_buffet
    @buffet = Buffet.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Buffet not found" }, status: :not_found
  end
end
