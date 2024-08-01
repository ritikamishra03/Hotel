# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice,:signed_in)
    sign_in(resource_name, resource)
    yeild resource if block_given?
    if current_user.admin?
      redirect_to admin_path
    end
  end
end
