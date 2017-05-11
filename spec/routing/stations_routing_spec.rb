require "rails_helper"

RSpec.describe StationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/stations").to route_to("stations#index")
    end
  end
end
