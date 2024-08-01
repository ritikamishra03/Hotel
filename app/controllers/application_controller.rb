class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    # before_action :after_sign_up_path_for

    def admin?
        current_user && current_user.admin?
    end

    def staff?
        current_user && current_user.staff?
    end

    def customer?
        current_user && current_user.customer?
    end

    def authorize_admin
        redirect_to(root_path, alert: 'Access denied!') unless admin?
    end

    def authorize_staff
        redirect_to(root_path, alert: 'Access denied!') unless admin? || staff?
    end

    def authorize_user
        redirect_to(root_path, alert: 'Access denied!') unless admin? || user?
    end

    protected

    def configure_permitted_parameters
        attributes = [:name,:role]
        devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
        devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end
      
    def after_sign_up_path_for
        # Rails.logger.info "User signed up: #{resource.email}"
        generate_otp
    end
    
      

    

end
