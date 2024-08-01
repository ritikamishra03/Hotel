class BillingMailer < ApplicationMailer
    def send_bill(user,booking)
        @user=user
        @booking=booking
        mail(to:@user.email, subject:'Your Bill From Hotel')
    end
end
