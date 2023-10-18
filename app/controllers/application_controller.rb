class ApplicationController < ActionController::Base

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
    keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number])
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
        root_path
    elsif resource_or_scope == :admin
            admin_session_path
    else
        root_path
    end

  end
end