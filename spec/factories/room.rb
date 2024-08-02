# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    # sequence(:name) { |n| "Room #{n}" }
    sequence(:room_number) { |n| n }
    association :room_type, factory: :room_type
    status { 'available' }
  end
end
