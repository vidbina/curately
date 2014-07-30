require 'rails_helper'

RSpec.describe "Updates", :type => :request do
  let(:board) { create(:board) }

  after(:each) do
    Board.destroy_all
  end

  describe "GET /updates" do
    it "works! (now write some real specs)" do
      get board_updates_path(board_id: board.id)
      expect(response.status).to be(200)
    end
  end
end
