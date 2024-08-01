
FactoryBot.define do
  factory :booking do
    association :user, factory: :user
    association :room, factory: :room
    check_in { Time.zone.now }
    check_out { Time.zone.now + 1.day }
  end
end
