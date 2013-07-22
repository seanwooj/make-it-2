require 'spec_helper'

describe "Machine Searche" do
  describe "GET /machines" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get machines_path
      response.status.should be(200)
    end

    context "search function" do
      context "autocomplete" do
        it "displays the correct address" do
          visit machines_path
          fill_in "address", with: "los angeles"
        end
      end
    end

  end
end
