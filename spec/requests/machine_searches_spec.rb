require 'spec_helper'

describe "Machine Searches" do
  describe "GET /machines" do

    context "search function" do
      context "autocomplete" do
        before(:each) do
          FactoryGirl.create(:machine)
        end

        it "does not find machines in los angeles", :js => true do
          visit machines_path
          sleep 1
          fill_in "address", with: "los ang"
          sleep 1
          find('#address').native.send_keys :arrow_down
          sleep 1
          find('#address').native.send_keys :return
          sleep 1
          page.should_not have_content "Los Angeles, CA 90026, USA"
        end

        it "finds machines in newport beach", :js => true do
          visit machines_path
          sleep 1
          fill_in "address", with: "newport beach, c"
          sleep 1
          find('#address').native.send_keys :arrow_down
          sleep 1
          find('#address').native.send_keys :return
          sleep 1
          page.should have_content "86 Lessay, Newport Coast, CA"
        end

        it "clears out the window when new searches are performed", js: true do
          10.times { FactoryGirl.create(:machine_with_random_location) }
          visit machines_path
          sleep 1
          fill_in "address", with: "los angeles, ca"
          find("#address").native.send_keys :return
          sleep 1
          page.should have_content "Los Angeles, CA 90026, USA"
          fill_in "address", with: "newport beach, ca"
          find("#address").native.send_keys :return
          sleep 1
          page.should have_content "Newport Coast, CA 92657, USA"
          page.should_not have_content "Los Angeles, CA 90026, USA"
        end

        it "finds machines from the homepage", :js => true do
          visit root_path
          sleep 1
          fill_in "address", with: "newport beach, c"
          sleep 1
          find('#address').native.send_keys :arrow_down
          sleep 1
          find('#address').native.send_keys :return
          sleep 1
          page.should have_content "86 Lessay, Newport Coast, CA"
        end
      end
    end

  end
end
