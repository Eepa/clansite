require 'spec_helper'

describe "PlayerTanks" do
  describe "GET /player_tanks" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get player_tanks_path
      response.status.should be(200)
    end
  end
end
