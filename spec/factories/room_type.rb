# frozen_string_literal: true

FactoryBot.define do
  factory :room_type do
    sequence(:name) { |n| "RoomType #{n}" }
    # description { "A description of the room type" }
    rate { 100 }
  end
end
