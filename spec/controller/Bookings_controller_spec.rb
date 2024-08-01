require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
    let(:admin) { create(:user, :admin) }
    let(:staff) { create(:user, :staff) }
    let(:customer) { create(:user, :customer) }
    let(:room) { create(:room) }
    let(:booking) { create(:booking, user: customer, room: room) }
    let(:valid_attributes){
        {check_in:Time.zone.now, check_out:Time.zone.now+1.day}
    }
    

    describe "GET #index" do
        context "when admin" do
            before { sign_in admin}

            it  "returns a success response" do
                get :index
                expect(response).to  be_successful
            end
        end

        context "when staff" do
            before { sign_in staff}

            it "returns a success response" do
                get :index
                expect(response).to be_successful
            end
        end

        context "when customer" do
            before { sign_in customer}

            it "returns a success response" do
                get :index
                expect(response).to be_successful
            end
        end
    end

    describe "Get #show" do
        context "when authorized" do
            before {sign_in customer}

            it "returns a success response" do
                get :show, params: { id: booking.id }
                expect(response).to be_successful
            end
        end

        context "when not authorized" do 
            before { sign_in create(:user)}

            it "redirects to bookings path" do
                get :show, params: {id: booking.id}
                expect(response).to redirect_to(bookings_path)
                expect(flash[:alert]).to eq('You are not authorized to view this booking.')
            end
        end
    end

    describe "Get #new" do 
        before {sign_in customer}
        it "returns a success response" do
            get :new
            expect(response).to be_successful
        end
    end

    describe "Post #create" do
        before { sign_in customer }
        context "with valid params" do
            it "creates a new Booking" do
                expect {
                  post :create, params: { booking: valid_attributes }
                }
            end
        end

        context "with invalid params" do
            let(:invalid_attributes) { { room_id: nil } }
      
            it "renders the new template" do
              post :create, params: { booking: invalid_attributes }
              expect(response).to render_template("new")
            end
        end
    end

    describe "PATCH #update" do
    before { sign_in customer }

        context "with valid params" do
            let(:new_attributes) { { check_out: Time.zone.now + 2.days } }

            it "updates the requested booking" do
                expect {
                    patch :update, params: { booking: new_attributes }
                }
            end

            it "redirects to the bookings path" do
                patch :update, params: { id: booking.id, booking: new_attributes }
                expect(response).to redirect_to(bookings_path)
                expect(flash[:notice]).to eq('Booking was successfully updated.')
            end
        end

        context "with invalid params" do
            let(:invalid_attributes) { { room_id: nil } }

            it "renders the edit template" do
                patch :update, params: { id: booking.id, booking: invalid_attributes }
                expect(response).to render_template("edit")
            end
        end
    end

    describe "DELETE #destroy" do
    before { sign_in customer }

        it "destroys the requested booking" do
            booking = create(:booking, user: customer)
            expect {
                delete :destroy, params: { id: booking.id }
            }.to change(Booking, :count).by(-1)
        end

        it "redirects to the bookings list" do
            booking = create(:booking, user: customer)
            delete :destroy, params: { id: booking.id }
            expect(response).to redirect_to(bookings_url)
            expect(flash[:notice]).to eq('Booking was successfully destroyed.')
        end
    end

    describe "PATCH #check_in" do
    before { sign_in staff }

        it "checks in the guest" do
            patch :check_in, params: { id: booking.id }
            booking.reload
            expect(booking.status).to eq('checked_in')
        end

        it "redirects to the bookings path with success notice" do
            patch :check_in, params: { id: booking.id }
            expect(response).to redirect_to(bookings_path)
            expect(flash[:notice]).to eq('Guest checked in successfully.')
        end
    end

    describe "PATCH #check_out" do
    before { sign_in staff }

        it "checks out the guest and sends the bill" do
            expect {
                patch :check_out, params: { id: booking.id }
            }.to change { ActionMailer::Base.deliveries.count }.by(2)
            booking.reload
            expect(booking.status).to eq('checked_out')
        end

        it "redirects to the booking bill with success notice" do
            patch :check_out, params: { id: booking.id }
            expect(response).to redirect_to(bill_booking_path(booking))
            expect(flash[:notice])==('Guest checked out successfully and bill has been sent to registered email')
        end
    end

    describe "GET #bill" do
    before { sign_in customer }

        it "sends the bill to the customer's email" do
            expect {
                get :bill, params: { id: booking.id }
            }.to change { ActionMailer::Base.deliveries.count }.by(1)
        end
    end
end