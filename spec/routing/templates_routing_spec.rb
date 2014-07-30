require "rails_helper"

describe TemplatesController do
  describe "routing" do
    let(:curator_id) { "123" }

    it "routes to #new" do
      expect(get: "/curators/#{curator_id}/template/new").to route_to("templates#new", curator_id: curator_id)
    end

    it "routes to #show" do
      expect(get: "/curators/#{curator_id}/template").to route_to("templates#show", curator_id: curator_id)
    end

    it "routes to #edit" do
      expect(get: "/curators/#{curator_id}/template/edit").to route_to("templates#edit", curator_id: curator_id)
    end

    it "routes to #create" do
      expect(post: "/curators/#{curator_id}/template").to route_to("templates#create", curator_id: curator_id)
    end

    it "routes to #update" do
      expect(put: "/curators/#{curator_id}/template").to route_to("templates#update", curator_id: curator_id)
    end

    it "routes to #destroy" do
      expect(delete: "/curators/#{curator_id}/template").to route_to("templates#destroy", curator_id: curator_id)
    end

  end
end
