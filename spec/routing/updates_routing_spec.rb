require "rails_helper"

RSpec.describe UpdatesController, :type => :routing do
  describe "routing" do
    let(:board_id) { "132" }

    it "routes to #index" do
      expect(:get => "/boards/#{board_id}/updates").to route_to("updates#index", :board_id => board_id)
    end

    it "routes to #new" do
      expect(:get => "/boards/#{board_id}/updates/new").to route_to("updates#new", board_id: board_id)
    end

    it "routes to #show" do
      expect(:get => "/boards/#{board_id}/updates/1").to route_to("updates#show", id: "1", board_id: board_id)
    end

    it "routes to #edit" do
      expect(:get => "/boards/#{board_id}/updates/1/edit").to route_to("updates#edit", id: "1", board_id: board_id)
    end

    it "routes to #create" do
      expect(:post => "/boards/#{board_id}/updates").to route_to("updates#create", board_id: board_id)
    end

    it "routes to #update" do
      expect(:put => "/boards/#{board_id}/updates/1").to route_to("updates#update", id: "1", board_id: board_id)
    end

    it "routes to #destroy" do
      expect(:delete => "/boards/#{board_id}/updates/1").to route_to("updates#destroy", id: "1", board_id: board_id)
    end

  end
end
