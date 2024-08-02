# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomTypesController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:room_type) { create(:room_type) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: room_type.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new RoomType' do
        expect do
          post :create, params: { room_type: { name: 'Deluxe', rate: 150.0 } }
        end.to change(RoomType, :count).by(1)
        expect(response).to redirect_to(room_types_path)
        expect(flash[:notice]).to eq('Room type was successfully created.')
      end
    end

    context 'with invalid params' do
      it 'renders the new template' do
        post :create, params: { room_type: { name: nil, rate: 150.0 } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: room_type.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the room type and redirects to the room types path' do
        patch :update, params: { id: room_type.id, room_type: { name: 'Super Deluxe', rate: 200.0 } }
        room_type.reload
        expect(room_type.name).to eq('Super Deluxe')
        expect(room_type.rate).to eq(200.0)
        expect(response).to redirect_to(room_types_path)
        expect(flash[:notice]).to eq('Room type was successfully updated.')
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        patch :update, params: { id: room_type.id, room_type: { name: nil, rate: 200.0 } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the room type and redirects to the room types path' do
      room_type = create(:room_type)
      expect do
        delete :destroy, params: { id: room_type.id }
      end.to change(RoomType, :count).by(-1)
      expect(response).to redirect_to(room_types_path)
      expect(flash[:notice]).to eq('Room type was successfully destroyed.')
    end
  end
end
