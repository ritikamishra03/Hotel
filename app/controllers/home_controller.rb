# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.admin?
      redirect_to new_otp_path
    elsif current_user.staff?
      redirect_to new_otp_path
    else
      redirect_to new_otp_path
    end
  end

  def destroy
    (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    # set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    # respond_to_on_destroy
    redirect_to root_path
  end
end
