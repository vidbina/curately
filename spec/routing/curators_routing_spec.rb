require "rails_helper"

describe CuratorsController do
  describe "routing" do

    it "routes to #index" do
      get("/curators").should route_to("curators#index")
    end

    it "routes to #new" do
      get("/curators/new").should route_to("curators#new")
    end

    it "routes to #show" do
      get("/curators/1").should route_to("curators#show", :id => "1")
    end

    it "routes to #edit" do
      get("/curators/1/edit").should route_to("curators#edit", :id => "1")
    end

    it "routes to #create" do
      post("/curators").should route_to("curators#create")
    end

    it "routes to #update" do
      put("/curators/1").should route_to("curators#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/curators/1").should route_to("curators#destroy", :id => "1")
    end

  end
end
