# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    name { 'Test User' }

    trait :admin do
      role { 'admin' }
    end

    trait :staff do
      role { 'staff' }
    end

    trait :customer do
      role { 'customer' }
    end
  end
end
