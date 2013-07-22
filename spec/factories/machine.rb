FactoryGirl.define do
  factory :machine do
    sequence(:name) { |n| "bleep #{n} bloop machine"}
    description "#{"this is a description " * 40 }"
    category "3d Printer"
    association :user, factory: :owner

    factory :machine_with_random_location do
      association :user, factory: :owner_with_random_location
    end

  end
end
