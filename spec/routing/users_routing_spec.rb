require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes to #index" do
      get("/users").should route_to("users#index")
    end

    it "routes to #new" do
      get("/users/new").should route_to("users#new")
    end

    it "routes to #show" do
      get("/users/1").should route_to("users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/users/1/edit").should route_to("users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/users").should route_to("users#create")
    end

    it "routes to #update" do
      put("/users/1").should route_to("users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/users/1").should route_to("users#destroy", :id => "1")
    end

    it "routes to #leave_clan" do
      put("users/1/leave_clan").should route_to("users#leave_clan", :id => "1")
    end

    it "routes to #update_clan_id" do
      put("users/1/update_clan_id").should route_to("users#update_clan_id", :id => "1")
    end

    it "routes to #join_clan" do
      get("users/1/join_clan").should route_to("users#join_clan", :id => "1")
    end


  end
end
