# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Booking, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:booking)).to be_valid
  end

  it 'valid with valid attributes' do
    booking = FactoryBot.build(:booking)
    expect(booking).to be_valid
  end

  it 'is invalid without a room' do
    booking = FactoryBot.build(:booking, room: nil)
    expect(booking).to_not be_valid
  end

  it 'is invalid without a user' do
    booking = FactoryBot.build(:booking, user: nil)
    expect(booking).to_not be_valid
  end

  it 'is invalid without a check_in date' do
    booking = FactoryBot.build(:booking, check_in: nil)
    expect(booking).to_not be_valid
  end

  it 'is invalid without a check_out date' do
    booking = FactoryBot.build(:booking, check_out: nil)
    expect(booking).to_not be_valid
  end

  it 'is invalid if check_out date is before check_in date' do
    booking = FactoryBot.build(:booking, check_in: Date.today, check_out: Date.yesterday)
    expect(booking).to_not be_valid
  end

  it 'belongs to a user' do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user: user)
    expect(booking.user).to eq(user)
  end

  it 'belongs to a room' do
    room = FactoryBot.create(:room)
    booking = FactoryBot.create(:booking, room: room)
    expect(booking.room).to eq(room)
  end
end
