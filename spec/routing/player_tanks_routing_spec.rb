require "spec_helper"

describe PlayerTanksController do
  describe "routing" do

    it "routes to #index" do
      get("/player_tanks").should route_to("player_tanks#index")
    end

    it "routes to #new" do
      get("/player_tanks/new").should route_to("player_tanks#new")
    end

    it "routes to #show" do
      get("/player_tanks/1").should route_to("player_tanks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/player_tanks/1/edit").should route_to("player_tanks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/player_tanks").should route_to("player_tanks#create")
    end

    it "routes to #update" do
      put("/player_tanks/1").should route_to("player_tanks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/player_tanks/1").should route_to("player_tanks#destroy", :id => "1")
    end

  end
end
