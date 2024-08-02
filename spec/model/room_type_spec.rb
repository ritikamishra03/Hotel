# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomType, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:room_type)).to be_valid
  end

  it 'valid with valid attributes' do
    room_type = FactoryBot.build(:room_type)
    expect(room_type).to be_valid
  end

  it 'is invalid without name ' do
    room_type = FactoryBot.build(:room_type, name: nil)
    expect(room_type).to_not be_valid
  end

  it 'is invalid without rate' do
    room_type = FactoryBot.build(:room_type, rate: nil)
    expect(room_type).to_not be_valid
  end
end
