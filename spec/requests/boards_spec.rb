require 'rails_helper'

RSpec.describe "Boards", :type => :request do
  let(:board) { create(:board) }
  let(:user) { create(:user) }

  after(:all) do
    User.destroy_all
  end

  after(:each) do
    Board.destroy_all
  end

  describe "GET /boards" do
    it "is unauthorized when credentials are missing" do
      get boards_path, { format: 'json' }
      expect(response.status).to be(401)
    end

    it "returns the boards when authorized" do
      curatorship = create(:curatorship, user: user)
      membership = create(:membership, user: user)
      3.times { create(:board, curator: curatorship.curator) }
      2.times { create(:board, client: membership.client) }
      4.times { create(:board) }
      get boards_path, { format: 'json' }, {
        'Authorization' => basic_auth(user.email, user.password)
      }
      expect(JSON.parse(response.body).length).to eq(5)
    end
  end
end
