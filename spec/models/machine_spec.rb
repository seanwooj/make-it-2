require 'spec_helper'

describe Machine do
  subject(:valid_machine) do
    FactoryGirl.build(:machine)
  end
  it { should belong_to(:user) }
  it { should have_many(:locations) }

  it "has a valid factory" do
    valid_machine.should be_valid
  end

  it "is invalid with no name" do
    valid_machine.name = ""
    valid_machine.should_not be_valid
  end

  it "is invalid with no category" do
    valid_machine.category = ""
    valid_machine.should_not be_valid
  end

  it "is invalid with a nonexistant category" do
    valid_machine.category = "invalid"
    valid_machine.should_not be_valid
  end

  it "is invalid with no user_id" do
    machine = FactoryGirl.create(:machine)
    machine.user_id.should_not be_nil
  end

  it "is invalid with no description" do
    valid_machine.description = ""
    valid_machine.should_not be_valid
  end

  describe "location functionality" do
    it "returns the correct latitude and longitude" do
      machine = FactoryGirl.create(:machine)
      latlng = machine.latlng
      latlng.should == {:lat => 33.6103025, :lng => -117.8353995}
    end

    it "returns the correct address object" do
      machine = FactoryGirl.create(:machine)
      address_info = machine.address_info
      address_info.should == { :lat => 33.6103025,
                               :lng => -117.8353995,
                               :address => "86 Lessay, Newport Coast, CA 92657, USA"
                             }
    end
  end

  context "search functionality" do
    before(:all) do
      10.times do
        FactoryGirl.create(:machine_with_random_location)
      end
      FactoryGirl.create(:machine)
    end

    it "creates 11 machines" do
      Machine.all.length.should == 11
    end

    describe "#search" do

      it "finds machines in los angeles" do
        machines = Machine.search("los angeles, ca")
        machines.last.locations.last.address.should include("Los Angeles")
      end

      it "finds machines in san francisco" do
        machines = Machine.search("san francisco, ca")
        machines.last.locations.last.address.should include("San Francisco")
      end

      it "finds machines everywhere!" do
        machines = Machine.search("san francisco, ca", {distance: 5000})
        machines.length.should == 11
      end

      it "finds machines nowhere :(" do
        machines = Machine.search("irvine, ca", {distance:0})
        machines.length.should == 0
      end

      #TODO have to change this later when I actually add laser cutters
      it "doesn't find any laser cutters" do
        machines = Machine.search("los angeles, ca", {category: "Laser Cutter"})
        machines.length.should == 0
      end
    end
  end
end
