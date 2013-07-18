FactoryGirl.define do
  factory :user do
    sequence(:full_name) { |n| "bleep#{n} bloop" }
    sequence(:email) { |n| "bleep#{n}@bloop.com" }
    password "password"
    has_machine false
  end
end