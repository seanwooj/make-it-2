require 'spec_helper'

describe MachinesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      pending
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'search.json'" do
    before(:each) do
      FactoryGirl.create(:machine)
      get :search, search: "newport beach, ca", distance: 20, format: :json
      @json_response = JSON.parse(response.body)

    end

    it { response.should be_ok }
    it { @json_response.should be_a_kind_of(Array) }
    it { @json_response[0].should be_a_kind_of(Hash) }
    it { @json_response[0]["name"].should match /bleep \d bloop machine/ }
    it { @json_response[0]["address_info"]["address"].should match /86 Lessay, Newport Coast, CA/ }
    it { @json_response[0]["address_info"]["lat"].should == 33.6103025 }
    it { @json_response[0]["address_info"]["lng"].should == -117.8353995 }

  end

end

