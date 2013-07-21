FactoryGirl.define do
  factory :user do
    sequence(:full_name) { |n| "bleep#{n} bloop" }
    sequence(:email) { |n| "bleep#{n}@bloop.com" }
    password "password"
    has_machine false
  end

  factory :location do
    user
    address "86 Lessay, Newport Coast, CA 92657, USA"
    address_2 "Upstairs Bedroom"
  end
end



#factory :user, aliases: [:author, :commenter] do
#  first_name    "John"
#  last_name     "Doe"
#  date_of_birth { 18.years.ago }
#end
#
#factory :post do
#  author
#  # instead of
#  # association :author, factory: :user
#  title "How to read a book effectively"
#  body  "There are five steps involved."
#end
#
#factory :comment do
#  commenter
#  # instead of
#  # association :commenter, factory: :user
#  body "Great article!"
#end