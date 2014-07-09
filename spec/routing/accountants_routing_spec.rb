require "rails_helper"

describe AccountantsController do
  describe "routing" do

    it "routes to #index" do
      get("/accountants").should route_to("accountants#index")
    end

    it "routes to #new" do
      get("/accountants/new").should route_to("accountants#new")
    end

    it "routes to #show" do
      get("/accountants/1").should route_to("accountants#show", :id => "1")
    end

    it "routes to #edit" do
      get("/accountants/1/edit").should route_to("accountants#edit", :id => "1")
    end

    it "routes to #create" do
      post("/accountants").should route_to("accountants#create")
    end

    it "routes to #update" do
      put("/accountants/1").should route_to("accountants#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/accountants/1").should route_to("accountants#destroy", :id => "1")
    end

  end
end
