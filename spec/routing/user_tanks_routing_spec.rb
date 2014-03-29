require "spec_helper"

describe UserTanksController do
  describe "routing" do

    it "routes to #index" do
      get("/user_tanks").should route_to("user_tanks#index")
    end

    it "routes to #new" do
      get("/user_tanks/new").should route_to("user_tanks#new")
    end

    it "routes to #show" do
      get("/user_tanks/1").should route_to("user_tanks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_tanks/1/edit").should route_to("user_tanks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_tanks").should route_to("user_tanks#create")
    end

    it "routes to #update" do
      put("/user_tanks/1").should route_to("user_tanks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_tanks/1").should route_to("user_tanks#destroy", :id => "1")
    end

  end
end
