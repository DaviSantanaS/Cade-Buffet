class ApplicationController < ActionController::Base
  before_action :check_buffet_completion, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :buffet_owner])
  end

  def check_buffet_completion
    return unless user_signed_in? && current_user.buffet_owner? && current_user.buffet.nil?
    allowed_paths = [new_buffet_path, buffets_path]
    unless allowed_paths.include?(request.path)
      flash[:notice] = 'You need to complete your buffet registration before continue.'
      redirect_to new_buffet_path
    end
  end
end
