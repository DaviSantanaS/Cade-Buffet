class BuffetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_buffet, only: [:show, :edit, :update]

  def index
    @buffets = Buffet.all
  end

  def show;  end

  def new
      @buffet = Buffet.new
  end

  def create
  @buffet = Buffet.create!(buffet_params.merge(user_id: current_user.id))
    if current_user.buffet_owner?
      if @buffet.save
        redirect_to @buffet, notice: "Buffet created successfully"
      else
        flash[:now] = "Error creating buffet."
        render :new
      end
    else
      redirect_to root_path, alert: "Only buffet owners can perform this action"
    end
  end

  def edit
    redirect_to root_path, alert: "Only buffet owners can perform this action" unless current_user.actual_buffet_owner?(@buffet)
  end

  def update
    if current_user.actual_buffet_owner?(@buffet)
      if @buffet.update(buffet_params)
        redirect_to @buffet, notice: "Buffet updated successfully"
      else
        flash[:now] = "Error updating buffet."
        render :edit
      end
    else
      redirect_to root_path, alert: "Only buffet owners can perform this action"
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
                                   :zip_code, :description, :payment_methods)


  end

end
