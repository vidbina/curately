require "rails_helper"

describe CuratorsController do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/curators").to route_to("curators#index")
    end

    it "routes to #new" do
      expect(get: "/curators/new").to route_to("curators#new")
    end

    it "routes to #show" do
      expect(get: "/curators/1").to route_to("curators#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get: "/curators/1/edit").to route_to("curators#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post: "/curators").to route_to("curators#create")
    end

    it "routes to #update" do
      expect(put: "/curators/1").to route_to("curators#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete: "/curators/1").to route_to("curators#destroy", :id => "1")
    end

  end
end
