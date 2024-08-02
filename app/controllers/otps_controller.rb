# frozen_string_literal: true

class OtpsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    if current_user.valid_otp?(params[:otp])
      current_user.clear_otp
      if current_user.admin?
        redirect_to admin_path, notice: 'Logged in successfully'
      elsif current_user.staff?
        redirect_to staff_path, notice: 'Logged in successfully'
      else
        redirect_to customer_path, notice: 'Logged in successfully'
      end
    else
      flash.now[:alert] = 'Invalid or expired OTP'
      render :new
    end
  end
end
