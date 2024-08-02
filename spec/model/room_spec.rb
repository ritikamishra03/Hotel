# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:room)).to be_valid
  end

  it 'valid with valid attributes' do
    room = FactoryBot.build(:room)
    expect(room).to be_valid
  end

  it 'is invalid without room_number' do
    room = FactoryBot.build(:room, room_number: nil)
    expect(room).to_not be_valid
  end

  it 'is invalid without status' do
    room = FactoryBot.build(:room, status: nil)
    expect(room).to_not be_valid
  end

  it 'is invalid without room_type' do
    room = FactoryBot.build(:room, room_type: nil)
    expect(room).to_not be_valid
  end

  it 'is belongs to room_type' do
    room_type = FactoryBot.create(:room_type)
    room = FactoryBot.create(:room, room_type: room_type)
    expect(room.room_type).to eq(room_type)
  end
end
