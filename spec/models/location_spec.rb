require 'spec_helper'

describe Location do
  subject(:valid_location) do
    Location.new(
      address: "86 Lessay, Newport Coast, CA 92657, USA",
      address_2: "Upstairs Bedroom",
      user_id: 1,
      latitude: 33.6103025,
      longitude: -117.8353995,
      city: "Newport Coast"
    )
  end

  let(:uncompleted_location) do
    Location.new(
      address: "86 Lessay, Newport Coast, CA 92657, USA",
      user_id: 1,
      address_2: ""
    )
  end

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

      it 'creates the correct latitude and longitude when the model is saved if lat lng are not passed in via client' do
        uncompleted_location.longitude.should be_nil
        uncompleted_location.latitude.should be_nil
        uncompleted_location.save!
        uncompleted_location.latitude.should == 33.6103025
        uncompleted_location.longitude.should == -117.8353995
      end


      it 'assigns the correct city when the model is created when it doesnt have it on the server side' do
        uncompleted_location.city.should be_nil
        uncompleted_location.save!
        uncompleted_location.city.should == "Newport Coast"
      end

      it 'does not do server side lat/lng assignment when it was already completed on the client side' do
        valid_location.longitude.should_not be_nil
        valid_location.latitude.should_not be_nil
        valid_location.should_not_receive(:assign_city)
        valid_location.should_not_receive(:geocode)
        uncompleted_location.save
      end

      it "changes city and zip when address is changed" do
        valid_location.address = "543 Howard Street, San Francisco, CA"
        valid_location.save!
        valid_location.city.should == "San Francisco"
      end

      it "calls #assign_city when address is changed" do
        valid_location.address = "543 Howard Street, San Francisco, CA"
        valid_location.should_receive(:assign_city)
        valid_location.save!
      end

      it "changes coordinates when the address is changed" do
        valid_location.address = "543 Howard Street, San Francisco, CA"
        valid_location.save!
        valid_location.latitude.should == 37.7876368
        valid_location.longitude.should == -122.3968377
      end

      it "does not call #assign_city when the city has already been changed on the client side" do
        valid_location.address = "543 Howard Street, San Francisco, CA"
        valid_location.city = "San Francisco"
        valid_location.should_not_receive(:assign_city)
        valid_location.save!
      end
    end
  end
end

