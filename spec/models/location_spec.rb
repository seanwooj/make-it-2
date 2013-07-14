require 'spec_helper'

describe Location do
  context 'New location object' do
    let!(:location) { Location.new(
      address_1: "86 Lessay",
      address_2: "Upstairs Bedroom",
      city: "Newport Coast",
      state: "California",
      zipcode: "92657",
      country: "United States of America",
      user_id: 1
    ) }

    it 'is valid when all fields are populated' do
      location.should be_valid
    end

    it 'is not valid with fields removed' do
      location.address_1 = nil
      location.should_not be_valid
    end

    it 'is valid without address_2' do
      location.address_2 = nil
      location.should be_valid
    end
  end
end

