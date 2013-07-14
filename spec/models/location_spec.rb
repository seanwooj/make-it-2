require 'spec_helper'

describe Location do
  subject(:valid_location) { Location.new(
      address_1: "86 Lessay",
      address_2: "Upstairs Bedroom",
      city: "Newport Coast",
      state: "California",
      zipcode: "92657",
      country: "United States of America",
      user_id: 1
  ) }

  it { should belong_to(:user) }

  context 'New location object' do
    it 'is valid when all fields are populated' do
      valid_location.should be_valid
    end

    it 'is not valid with fields removed' do
      valid_location.address_1 = nil
      valid_location.should_not be_valid
    end

    it 'is valid without address_2' do
      valid_location.address_2 = nil
      valid_location.should be_valid
    end
  end

  context 'geocoder' do
    describe '#create_geocoded_address' do
      it 'creates a geocoded address from the fields' do
        valid_location.send(:create_geocoded_address)
        valid_location.save!
        valid_location.address_for_geocoder.should == "86 Lessay, Newport Coast, California 92657, United States of America"
      end

      it 'creates a geocoded address when the model is saved' do
        valid_location.address_for_geocoder.should be_nil
        valid_location.save!
        valid_location.address_for_geocoder.should == "86 Lessay, Newport Coast, California 92657, United States of America"
      end

      it 'creates the correct latitude and longitude when the model is saved' do
        valid_location.longitude.should be_nil
        valid_location.latitude.should be_nil
        valid_location.save!
        valid_location.latitude.should == 33.6103025
        valid_location.longitude.should == -117.8353995
      end
    end
  end
end

