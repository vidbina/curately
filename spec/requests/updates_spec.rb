require 'rails_helper'

RSpec.describe "Updates", :type => :request do
  let(:user) { create(:user) }
  let(:board) { create(:board) }
  let(:membership) { create(:membership, client: board.client, user: user) }

  after(:each) do
    Membership.destroy_all
    User.destroy_all
    Board.destroy_all
  end

  describe "GET /updates" do
    it "works! (now write some real specs)" do
      get board_updates_path(board_id: board.id), { format: 'json' }, {
        'Authorization' => basic_auth(membership.user.email, membership.user.password)
      }
      expect(response.status).to be(200)
    end
  end
end
