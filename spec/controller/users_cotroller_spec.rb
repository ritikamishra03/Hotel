# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:admin) { create(:user, :admin, name: 'Admin User') }
  let(:staff) { create(:user, :staff, name: 'Staff User') }
  let(:customer) { create(:user, :customer, name: 'Customer User') }

  describe 'Get #index' do
    context 'when admin' do
      before { sign_in admin }

      it 'returns a success response' do
        get :index
        expect(response).to be_successful
      end
    end
  end

  describe 'Get #show' do
    before { sign_in admin }

    it 'return a success response' do
      get :show, params: { id: customer.id }
      expect(response).to be_successful
    end
  end

  describe 'Get #edit' do
    context 'when admin' do
      before { sign_in admin }

      it 'returns a success response' do
        get :edit, params: { id: customer.id }
        expect(response).to be_successful
      end
    end

    context 'when not admin' do
      before { sign_in staff }

      it 'redirects to users path' do
        get :edit, params: { id: customer.id }
        expect(response)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when admin' do
      before { sign_in admin }

      it 'updates the user and redirects to users path' do
        patch :update, params: { id: customer.id, user: { role: 'staff' } }
        customer.reload
        expect(customer.role).to eq('staff')
        expect(response).to redirect_to(users_path)
        expect(flash[:notice]).to eq('User was successfully updated.')
      end
    end

    context 'when not admin' do
      before { sign_in staff }

      it 'does not update the user and redirects to users path' do
        patch :update, params: { id: customer.id, user: { role: 'admin' } }
        customer.reload
        expect(customer.role).not_to eq('admin')
        expect(response)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when admin' do
      before { sign_in admin }

      it 'destroys the user and redirects to users path' do
        user = create(:user)
        expect do
          delete :destroy, params: { id: user.id }
        end.to change(User, :count).by(-1)
        expect(response).to redirect_to(users_path)
        expect(flash[:notice]) == ('User was successfully destroyed.')
      end
    end

    context 'when not admin' do
      before { sign_in staff }

      it 'does not destroy the user and redirects to users path' do
        user = create(:user)
        expect do
          delete :destroy, params: { id: user.id }
        end
        expect(response)
      end
    end
  end
end
