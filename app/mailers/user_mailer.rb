# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def send_otp
    @user = params[:user]

    mail(to: @user.email, subject: 'Your OTP Code')
  end
end
