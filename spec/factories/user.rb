FactoryGirl.define do
  factory :user do
    sequence(:full_name) { |n| "bleep#{n} bloop" }
    sequence(:email) { |n| "bleep#{n}@bloop.com" }
    password "password"
    has_machine false

    after(:build) do |user|
      user.locations << FactoryGirl.build(:location)
    end

    factory :owner, class: User do

    end

    factory :owner_with_random_location, class: User do
      after(:build) do |owner|
        #todo KLUGY - THIS SHIT IS SUPER KLUGY, running 2 after builds
        owner.locations = []
        owner.locations << FactoryGirl.build(:random_location)
      end
    end

  end

  factory :location do
    address "86 Lessay, Newport Coast, CA 92657, USA"
    address_2 "Upstairs Bedroom"
    city "Newport Coast"
    latitude 33.6103025
    longitude -117.8353995

    factory :random_location do
      address do
        addresses = [
            "86 Lessay, Newport Coast, CA 92657, USA",
            "543 Howard Street, San Francisco, CA 94105, USA",
            "2661 Echo Park Ave, Los Angeles, CA 90026, USA"
        ]
        addresses.sample
      end
      address_2 ""
      latitude nil
      longitude nil
      city nil
    end
  end

end
