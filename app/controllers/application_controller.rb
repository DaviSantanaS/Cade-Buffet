class ApplicationController < ActionController::Base
  before_action :check_buffet_completion
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :buffet_owner])
  end

  def check_buffet_completion
    if user_signed_in? && current_user.buffet_owner? && current_user.buffet.nil? && !devise_controller?
      unless request.path.in?([new_buffet_path, buffets_path])
        flash[:notice] = 'Você precisa completar o cadastro do seu buffet'
        redirect_to new_buffet_path
      end
    end
  end
end

