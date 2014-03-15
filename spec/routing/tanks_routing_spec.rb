require "spec_helper"

describe TanksController do
  describe "routing" do

    it "routes to #index" do
      get("/tanks").should route_to("tanks#index")
    end

    it "routes to #new" do
      get("/tanks/new").should route_to("tanks#new")
    end

    it "routes to #show" do
      get("/tanks/1").should route_to("tanks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tanks/1/edit").should route_to("tanks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tanks").should route_to("tanks#create")
    end

    it "routes to #update" do
      put("/tanks/1").should route_to("tanks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tanks/1").should route_to("tanks#destroy", :id => "1")
    end

  end
end
