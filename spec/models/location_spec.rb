require 'spec_helper'

describe Location do
  subject(:valid_location) { Location.new(
      address: "86 Lessay, Newport Coast, CA 92657, USA",
      address_2: "Upstairs Bedroom",
      user_id: 1
  ) }

  it { should belong_to(:user) }

  context 'New location object' do
    it 'is valid when all fields are populated' do
      valid_location.should be_valid
    end

    it 'is not valid with fields removed' do
      valid_location.address = nil
      valid_location.should_not be_valid
    end

    it 'is valid without address_2' do
      valid_location.address_2 = nil
      valid_location.should be_valid
    end
  end

  context 'geocoder' do
    describe '#geocoder' do

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

