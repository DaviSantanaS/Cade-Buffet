class BuffetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_buffet, only: [:show, :edit, :update]

  def index
    @buffets = Buffet.all
  end

  def show;  end

  def new
      @buffet = Buffet.new
      @user = current_user
  end

  def create
    @buffet = Buffet.create!(buffet_params)
    if @buffet.save
      redirect_to @buffet, notice: "Buffet created successfully"
    else
      flash[:now] = "Error creating buffet."
      render :new
    end
  end


  def edit; end

  def update
    if @buffet.update(buffet_params)
      redirect_to @buffet, notice: "Buffet updated successfully"
    else
      flash[:now] = "Error updating buffet."
      render :edit
    end
  end

  private

  def set_buffet
    @buffet = Buffet.find(params[:id])
  end


  def buffet_params
    params.require(:buffet).permit(:name, :company_name,
                                   :cnpj, :phone, :contact_email,
                                   :address, :district, :state, :city,
                                   :zip_code, :description, :payment_methods, :user_id)


  end

end
