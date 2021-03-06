class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_breadcrumbs
  before_action :set_user_notebooks
  include Pagy::Backend

  def configure_permitted_parameters
    added_attrs = [:username, :email, :avatar, :password_confimration, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def add_breadcrumb(label, path=nil)
    @breadcrumbs << {
      label: label,
      path: path
    }
  end

  def set_breadcrumbs
    @breadcrumbs = []
  end

  def set_user_notebooks
    if user_signed_in?
      @user_notebooks = current_user.notebooks
    else
      @user_notebooks = []
    end
  end
end
