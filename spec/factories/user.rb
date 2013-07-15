FactoryGirl.define do
  factory :user do
    sequence(:full_name) { |n| "bleep#{n} bloop" }
    sequence(:email) { |n| "bleep#{n}@bloop.com" }
    password "password"
    address "86 lessay, newport coast, ca"
    has_machine false
  end
end