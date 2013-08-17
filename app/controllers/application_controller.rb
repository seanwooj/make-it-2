class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # TODO move this before filter and configure_permitted parameters to another controller, not the application controller
  # what it does presently is to allow for custom fields in devise's sign up form
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:full_name, :email, :password, :password_confirmation,
                                                            locations_attributes: [:address, :address_2, :city, :latitude, :longitude ]) }
  end
end
