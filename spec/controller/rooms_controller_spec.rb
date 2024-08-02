# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:room_type) { create(:room_type) }
  let(:room) { create(:room, room_type: room_type) }

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
      get :show, params: { id: room.id }
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
      it 'creates a new Room' do
        expect do
          post :create,
               params: { room: { room_number: 101, room_type_id: room_type.id, status: 'available' } }
        end.to change(Room, :count).by(1)
        expect(response).to redirect_to(rooms_path)
        expect(flash[:notice]).to eq('Room was successfully created.')
      end
    end

    context 'with invalid params' do
      it 'renders the new template' do
        post :create, params: { room: { room_number: nil, room_type_id: room_type.id, status: 'available' } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: room.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the room and redirects to the rooms path' do
        patch :update,
              params: { id: room.id, room: { room_number: 102, room_type_id: room_type.id, status: 'available' } }
        room.reload
        expect(room.room_number)
        expect(response).to redirect_to(rooms_path)
        expect(flash[:notice]).to eq('Room was successfully updated.')
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        patch :update,
              params: { id: room.id, room: { room_number: nil, room_type_id: room_type.id, status: 'available' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the room and redirects to the rooms path' do
      room = create(:room)
      expect do
        delete :destroy, params: { id: room.id }
      end.to change(Room, :count).by(-1)
      expect(response).to redirect_to(rooms_path)
      expect(flash[:notice]).to eq('Room was successfully destroyed.')
    end
  end
end
